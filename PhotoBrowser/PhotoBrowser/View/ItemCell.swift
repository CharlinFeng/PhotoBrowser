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
    
    @IBOutlet weak var imgVTMC: NSLayoutConstraint!
    
    @IBOutlet weak var imgVLMC: NSLayoutConstraint!
    
    
    
    
    
//    @IBOutlet weak var layoutView: UIView!
    
    @IBOutlet weak var asHUD: NVActivityIndicatorView!
    
    var hasHDImage: Bool = false
    
    var isFix: Bool = false
    
    var isDeinit: Bool = false
    
    var isAlive: Bool = true
    
    fileprivate var doubleTapGesture: UITapGestureRecognizer!
    
    fileprivate var singleTapGesture: UITapGestureRecognizer!
    
    lazy var screenH: CGFloat = UIScreen.main.bounds.size.height
    lazy var screenW: CGFloat = UIScreen.main.bounds.size.width
    
    deinit{
        
        cache = nil
        self.asHUD?.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }
}


extension ItemCell: UIScrollViewDelegate{
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ItemCell.doubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 1
        
        singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(ItemCell.singleTap(_:)))
        singleTapGesture.require(toFail: self.doubleTapGesture)
        singleTapGesture.numberOfTapsRequired = 1
        singleTapGesture.numberOfTouchesRequired = 1
        addGestureRecognizer(doubleTapGesture)
        addGestureRecognizer(singleTapGesture)
        
        scrollView.delegate = self
        
        msgContentTextView.textContainerInset = UIEdgeInsets.zero
        
        NotificationCenter.default.addObserver(self, selector: #selector(ItemCell.didRotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        //HUD初始化
        asHUD.layer.cornerRadius = 40
//        scrollView.layer.borderColor = UIColor.redColor().CGColor
//        scrollView.layer.borderWidth = 5
        asHUD.type = NVActivityIndicatorType.ballTrianglePath
        
        //更新约束:默认居中
        self.imgVLMC.constant = (self.screenW - 120)/2
        self.imgVTMC.constant = (self.screenH - 120)/2
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
    }
    
    
    
    func didRotate(){

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {[unowned self] () -> Void in
            if self.imageV.image != nil {self.imageIsLoaded(self.imageV.image!, needAnim: false)}
        })
    }
    

    
    func doubleTap(_ tapG: UITapGestureRecognizer){
        
        if !hasHDImage {return}
        
        let location = tapG.location(in: tapG.view)
        
        if scrollView.zoomScale <= 1 {
            
            if !(imageV.convert(imageV.bounds, to: imageV.superview).contains(location)) {return}
            
            let location = tapG.location(in: tapG.view)
            
            let rect = CGRect(x: location.x, y: location.y, width: 10, height: 10)

            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
                self.scrollView.zoom(to: rect, animated: false)
                var c = (self.screenH - self.imageV.frame.height) / 2
                if c <= 0 {c = 0}
                self.imgVTMC.constant = c
                print(self.imgVTMC.constant)
                self.imageV.setNeedsLayout()
                self.imageV.layoutIfNeeded()
                
            })
            
        }else{
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
                self.scrollView.setZoomScale(1, animated: false)
                self.imgVTMC.constant = (self.screenH - self.imageV.showSize.height) / 2
                self.imageV.setNeedsLayout()
                self.imageV.layoutIfNeeded()
            })
        }
        
        
    }
    
    func singleTap(_ tapG: UITapGestureRecognizer){
        
        if scrollView.zoomScale > 1 {
            
            doubleTap(doubleTapGesture)
            
        }else {
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: CFPBSingleTapNofi), object: nil)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {return imageV}

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        UIView.animateWithDuration(0.3, animations: { () -> Void in
//            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            var c = (self.screenH - self.imageV.frame.height) / 2
            if c <= 0 {c = 0}
            self.imgVTMC.constant = c
//            print(self.imgVTMC.constant)
//            self.imageV.setNeedsLayout()
//            self.imageV.layoutIfNeeded()
//        })
    }

    
    /**  复位  */
    func reset(){
        
        scrollView.setZoomScale(1, animated: false)
        msgContentTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    /**  数据填充  */
    func dataFill(){
        
        if photoType == PhotoBrowser.PhotoType.local {
            
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
            let url = URL(string: photoModel.hostHDImgURL)!
            
            if cache == nil {cache = Cache<UIImage>(name: CFPBCacheKey)}
            
            if format == nil{format = Format(name: photoModel.hostHDImgURL, diskCapacity: 10 * 1024 * 1024, transform: { img in
                return img
            })}

            cache.fetch(key: photoModel.hostHDImgURL,  failure: {[unowned self] fail in
                
                if !self.isAlive {return}
                
                self.showAsHUD()
                DispatchQueue.main.async(execute: { () -> Void in
                    
                    //更新约束:默认居中
                    self.imgVLMC.constant = (self.screenW - 120)/2
                    self.imgVTMC.constant = (self.screenH - 120)/2
                })
                self.imageV.image = self.photoModel.hostThumbnailImg
                
                self.cache.fetch(URL: URL(string: self.photoModel.hostHDImgURL)!, failure: {fail in
                    
                    print("失败\(fail)")
                    
                    }, success: {[unowned self] img in
                    
                    if !UserDefaults.standard.bool(forKey: CFPBShowKey) {return}
                    
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

                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.06 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {[unowned self] () -> Void in

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
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {[unowned self] () -> Void in
                
                self.reset()
        }
    }
    
    
    func toggleDisplayBottomBar(_ isHidden: Bool){
        
        bottomContentView.isHidden = isHidden
    }
    
    /** 图片数据已经装载 */
    func imageIsLoaded(_ img: UIImage,needAnim: Bool){
        self.scrollView.setZoomScale(1, animated: true)
        if !hasHDImage {return}
        
        if vc == nil{return}
        
        //图片尺寸
        let imgSize = img.size
        
        var boundsSize = self.bounds.size
        
        //这里有一个奇怪的bug，横屏时，bounds居然是竖屏的bounds
        if vc.view.bounds.size.width > vc.view.bounds.size.height {
        
            if boundsSize.width < boundsSize.height {
            
                boundsSize = CGSize(width: boundsSize.height, height: boundsSize.width)
            }
        
        }
        
        let contentSize = boundsSize.sizeMinusExtraWidth

        let showSize = CGSize.decisionShowSize(imgSize, contentSize: contentSize)
    
        imageV.showSize = showSize
        
        DispatchQueue.main.async(execute: {[unowned self] () -> Void in
            
            self.imgVHC.constant = showSize.height
            self.imgVWC.constant = showSize.width
            self.imgVLMC.constant = 0
            self.imgVTMC.constant = (self.screenH - showSize.height) / 2
            if self.photoModel.isLocal! {return}
  
            if !needAnim{return}
            self.scrollView.contentSize = showSize
            UIView.animate(withDuration: 0.25, animations: {[unowned self] () -> Void in
                UIView.setAnimationCurve(UIViewAnimationCurve.easeOut)
                self.imageV.setNeedsLayout()
                self.imageV.layoutIfNeeded()
            })
        })
    }
    

    /** 展示进度HUD */
    func showAsHUD(){
        
        if asHUD == nil {return}
        
        self.asHUD?.isHidden = false
        asHUD?.startAnimating()
        
        UIView.animate(withDuration: 0.25, animations: {[unowned self] () -> Void in
            self.asHUD?.alpha = 1
        })
    }
    
    
    /** 移除 */
    func dismissAsHUD(_ needAnim: Bool){
        
        if asHUD == nil {return}
        
        if needAnim{
        
            UIView.animate(withDuration: 0.25, animations: {[unowned self] () -> Void in
                self.asHUD?.alpha = 0
                }, completion: { (complete) -> Void in
                    self.asHUD?.isHidden = true
                    self.asHUD?.stopAnimating()
            }) 
            
        }else{
            
            self.asHUD?.alpha = 0
            self.asHUD?.isHidden = true
            self.asHUD?.stopAnimating()
        }


    }
    

}
