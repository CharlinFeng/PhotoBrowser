//
//  ItemCell.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    var photoModel: PhotoBrowser.PhotoModel!{didSet{dataFill()}}
    
    var photoType: PhotoBrowser.PhotoType!
    
    var isHiddenBar: Bool = true{didSet{toggleDisplayBottomBar(isHiddenBar)}}
    
    weak var vc: UIViewController!
    
    /**  缓存  */
    var cache: Cache<UIImage>!
    
    /**  format  */
    var format: Format<UIImage>!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageV: ShowImageView!
    
    @IBOutlet weak var bottomContentView: UIView!
    
    @IBOutlet weak var msgTitleLabel: UILabel!
    
    @IBOutlet weak var msgContentTextView: UITextView!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var imgVHC: NSLayoutConstraint!
    
    @IBOutlet weak var imgVWC: NSLayoutConstraint!
    
    @IBOutlet weak var layoutView: UIView!
    
    @IBOutlet weak var asHUD: NVActivityIndicatorView!
    
    var hasHDImage: Bool = false
    
    var isFix: Bool = false
    
    var isDeinit: Bool = false
    
    var isAlive: Bool = true
    
    lazy private var doubleTapGesture: UITapGestureRecognizer = {
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "doubleTap:")
        doubleTapGesture.numberOfTapsRequired = 2
        return doubleTapGesture
    }()
    
    lazy private var singleTapGesture: UITapGestureRecognizer = {
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: "singleTap:")
        singleTapGesture.numberOfTapsRequired = 1
        return singleTapGesture
    }()
    
    deinit{
        
        cache = nil
        self.asHUD?.removeFromSuperview()
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}


extension ItemCell: UIScrollViewDelegate{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        singleTapGesture.requireGestureRecognizerToFail(doubleTapGesture)
        
        self.addGestureRecognizer(doubleTapGesture)
        self.addGestureRecognizer(singleTapGesture)
        scrollView.delegate = self
        
        msgContentTextView.textContainerInset = UIEdgeInsetsZero
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didRotate", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        //HUD初始化
        asHUD.layer.cornerRadius = 40
        
        asHUD.type = NVActivityIndicatorType.BallTrianglePath
    }
    
    func didRotate(){

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {[unowned self] () -> Void in
            if self.imageV.image != nil {self.imageIsLoaded(self.imageV.image!, needAnim: false)}
        })
    }
    

    
    func doubleTap(tapG: UITapGestureRecognizer){
        
        if !hasHDImage {return}
        
        let location = tapG.locationInView(tapG.view)
        
        if scrollView.zoomScale <= 1 {
            
            if !(imageV.convertRect(imageV.bounds, toView: imageV.superview).contains(location)) {return}
            
            let location = tapG.locationInView(tapG.view)
            
            let rect = CGRectMake(location.x, location.y, 10, 10)
            
            scrollView.zoomToRect(rect, animated: true)
        }else{
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func singleTap(tapG: UITapGestureRecognizer){
        
        NSNotificationCenter.defaultCenter().postNotificationName(CFPBSingleTapNofi, object: nil)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {return layoutView}


    
    
    /**  复位  */
    func reset(){
        
        scrollView.setZoomScale(1, animated: false)
        msgContentTextView.setContentOffset(CGPointZero, animated: false)
    }
    
    /**  数据填充  */
    func dataFill(){
        
        if photoType == PhotoBrowser.PhotoType.Local {
            
            /**  本地图片模式  */
            hasHDImage = true
            
            /**  图片  */
            imageV.image = photoModel.localImg
            /** 图片数据已经装载 */
            imageIsLoaded(photoModel.localImg, needAnim: false)

        }else{
            
            self.hasHDImage = false
            
            self.imgVHC.constant = CFPBThumbNailWH
            self.imgVWC.constant = CFPBThumbNailWH
            
            self.imageV.image = nil
            /** 服务器图片模式 */
            let url = NSURL(string: photoModel.hostHDImgURL)!
            
            if cache == nil {cache = Cache<UIImage>(name: CFPBCacheKey)}
            
            if format == nil{format = Format(name: photoModel.hostHDImgURL, diskCapacity: 10 * 1024 * 1024, transform: { img in
                return img
            })}
            
            cache.fetch(key: photoModel.hostHDImgURL,  failure: {[unowned self] fail in
                
                if !self.isAlive {return}
                
                self.showAsHUD()
                
                self.imageV.image = self.photoModel.hostThumbnailImg
                
                self.cache.fetch(URL: NSURL(string: self.photoModel.hostHDImgURL)!, failure: {fail in
                    
                    print("失败\(fail)")
                    
                    }, success: {[unowned self] img in
                    
                    if !NSUserDefaults.standardUserDefaults().boolForKey(CFPBShowKey) {return}
                    
                    if !self.isAlive {return}
                    
                    if self.photoModel?.excetionFlag == false {return}
                    
                    if self.photoModel.modelCell !== self {return}
                    
                    self.hasHDImage = true
                    self.dismissAsHUD(true)
                    self.imageIsLoaded(img, needAnim: true)
                    self.imageV.image = img
                    
                })
                
            }, success: {[unowned self] img in
                
                if !self.isAlive {return}
                
                self.dismissAsHUD(false)
                
                self.imageV.image = img

                self.hasHDImage = true

                /** 图片数据已经装载 */

                if !self.isFix && self.vc.view.bounds.size.width > self.vc.view.bounds.size.height{

                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(0.06 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {[unowned self] () -> Void in

                        self.imageIsLoaded(img, needAnim: false)
                        self.isFix = true
                        })
                }else{
                    
                    self.imageIsLoaded(img, needAnim: false)
                }

            })
        }
        
        /**  标题  */
        if photoModel.titleStr != nil {msgTitleLabel.text = photoModel.titleStr}
        
        /**  内容  */
        if photoModel.descStr != nil {msgContentTextView.text = photoModel.descStr}
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
            Int64(0.1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {[unowned self] () -> Void in
                
                self.reset()
        }
    }
    
    
    func toggleDisplayBottomBar(isHidden: Bool){
        
        bottomContentView.hidden = isHidden
    }
    
    /** 图片数据已经装载 */
    func imageIsLoaded(img: UIImage,needAnim: Bool){
        
        if !hasHDImage {return}
        
        if vc == nil{return}
        
        //图片尺寸
        let imgSize = img.size
        
        var boundsSize = self.bounds.size
        
        //这里有一个奇怪的bug，横屏时，bounds居然是竖屏的bounds
        if vc.view.bounds.size.width > vc.view.bounds.size.height {
        
            if boundsSize.width < boundsSize.height {
            
                boundsSize = CGSizeMake(boundsSize.height, boundsSize.width)
            }
        
        }
        
        let contentSize = boundsSize.sizeMinusExtraWidth

        let showSize = CGSize.decisionShowSize(imgSize, contentSize: contentSize)
    
        dispatch_async(dispatch_get_main_queue(), {[unowned self] () -> Void in
            
            self.imgVHC.constant = showSize.height
            self.imgVWC.constant = showSize.width
            
            if self.photoModel.isLocal! {return}
            
            if !needAnim{return}
            
            UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
                UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut)
                self.imageV.setNeedsLayout()
                self.imageV.layoutIfNeeded()
            })
        })
    }
    

    /** 展示进度HUD */
    func showAsHUD(){
        
        if asHUD == nil {return}
        
        self.asHUD?.hidden = false
        asHUD?.startAnimation()
        
        UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
            self.asHUD?.alpha = 1
        })
    }
    
    
    /** 移除 */
    func dismissAsHUD(needAnim: Bool){
        
        if asHUD == nil {return}
        
        if needAnim{
        
            UIView.animateWithDuration(0.25, animations: {[unowned self] () -> Void in
                self.asHUD?.alpha = 0
                }) { (complete) -> Void in
                    self.asHUD?.hidden = true
                    self.asHUD?.stopAnimation()
            }
            
        }else{
            
            self.asHUD?.alpha = 0
            self.asHUD?.hidden = true
            self.asHUD?.stopAnimation()
        }


    }
    

}