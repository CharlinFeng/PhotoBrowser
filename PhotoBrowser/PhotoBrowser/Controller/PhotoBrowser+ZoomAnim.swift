//
//  PhotoBrowser+ZoomAnim.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

/** 力求用最简单的方式实现 */
extension PhotoBrowser{
    
    
    /** 展示动画: 妈妈，这里好复杂~~ */
    func zoomInWithAnim(page: Int){
        
        let photoModel = photoModels[page]
        
        let propImgV = UIImageView(frame: photoModel.sourceView.convertRect(photoModel.sourceView.bounds, toView: vc.view))
        propImgV.contentMode = UIViewContentMode.ScaleAspectFill
        propImgV.clipsToBounds = true
        
        vc.view.addSubview(propImgV)
        
        self.view.alpha = 0
        self.collectionView.alpha = 0
        
        if photoType == PhotoType.Local {
            
            propImgV.image = photoModel.localImg
            
            handleShowAnim(propImgV, thumbNailSize: nil)
            
        }else{
            
            let cache = Cache<UIImage>(name: CFPBCacheKey)
            
            cache.fetch(key:  photoModel.hostHDImgURL).onSuccess {[unowned self] image in
                
                propImgV.image = image
                
                self.handleShowAnim(propImgV, thumbNailSize: nil)
                
            }.onFailure{[unowned self] error in
                
                let size = CGSizeMake(CFPBThumbNailWH, CFPBThumbNailWH)
                
                if photoModel.hostThumbnailImg != nil {
                    
                    propImgV.image = photoModel.hostThumbnailImg
                    
                    self.handleShowAnim(propImgV, thumbNailSize: size)
                    
                }else{
                    
                    /** 这里需要大量修改 */
                    let img = UIImage.imageWithColor(size: CGSizeMake(CFPBThumbNailWH, CFPBThumbNailWH))
                    
                    propImgV.image = img
                    
                    self.handleShowAnim(propImgV, thumbNailSize: size)
                }
            }

        }
    }
    
    func handleShowAnim(propImgV: UIImageView,thumbNailSize: CGSize?){
        
        let showSize = thumbNailSize ?? CGSize.decisionShowSize(propImgV.image!.size, contentSize: vc.view.bounds.size)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseOut, animations: {[unowned self] () -> Void in
            propImgV.bounds = CGRectMake(0, 0, showSize.width, showSize.height)
            propImgV.center = self.vc.view.center
            self.view.alpha = 1
            }) { (complete) -> Void in
                propImgV.removeFromSuperview()
                self.collectionView.alpha = 1
        }
    }
    
    

    
    /** 关闭动画 */
    func zoomOutWithAnim(page: Int){
    
        let photoModel = photoModels[page]
        
        let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! ItemCell
        
        let cellImageView = cell.imageV
        
        let propImgV = UIImageView(frame: cellImageView.frame)
        propImgV.contentMode = UIViewContentMode.ScaleAspectFill
        propImgV.clipsToBounds = true
        propImgV.image = !cell.hasHDImage && photoModel.hostThumbnailImg == nil ? UIImage.imageWithColor(size: CGSizeMake(CFPBThumbNailWH, CFPBThumbNailWH)) : cellImageView.image
        propImgV.frame = cellImageView.frame

        vc.view.addSubview(propImgV)
        
        cellImageView.hidden = true
        photoModel.sourceView.hidden = true
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 20, options: UIViewAnimationOptions.CurveEaseOut, animations: {[unowned self] () -> Void in
                self.view.alpha = 0
                propImgV.frame = photoModel.sourceView.convertRect(photoModel.sourceView.bounds, toView: self.vc.view)
            
            }) { (complete) -> Void in
                
                photoModel.sourceView.hidden = false
                propImgV.removeFromSuperview()
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        }
    
    }
    
}