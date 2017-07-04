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
    func zoomInWithAnim(_ page: Int){
        
        let photoModel = photoModels[page]
        
        let propImgV = UIImageView(frame: photoModel.sourceView.convert(photoModel.sourceView.bounds, to: vc.view))
        propImgV.contentMode = UIViewContentMode.scaleAspectFill
        propImgV.clipsToBounds = true
        
        vc.view.addSubview(propImgV)
        
        self.view.alpha = 0
        self.collectionView.alpha = 0
        
        if photoType == PhotoType.local {
            
            propImgV.image = photoModel.localImg
            
            handleShowAnim(propImgV, thumbNailSize: nil)
            
        }else{
            
            let cache = Cache<UIImage>(name: CFPBCacheKey)
            
            cache.fetch(key:  photoModel.hostHDImgURL).onSuccess {[unowned self] image in
                
                propImgV.image = image
                
                self.handleShowAnim(propImgV, thumbNailSize: nil)
                
            }.onFailure{[unowned self] error in
                
                let size = CGSize(width: CFPBThumbNailWH, height: CFPBThumbNailWH)
                
                if photoModel.hostThumbnailImg != nil {
                    
                    propImgV.image = photoModel.hostThumbnailImg
                    
                    self.handleShowAnim(propImgV, thumbNailSize: size)
                    
                }else{
                    
                    /** 这里需要大量修改 */
                    let img = UIImage.imageWithColor(size: CGSize(width: CFPBThumbNailWH, height: CFPBThumbNailWH))
                    
                    propImgV.image = img
                    
                    self.handleShowAnim(propImgV, thumbNailSize: size)
                }
            }

        }
    }
    
    func handleShowAnim(_ propImgV: UIImageView,thumbNailSize: CGSize?){
        
        let showSize = thumbNailSize ?? CGSize.decisionShowSize(propImgV.image!.size, contentSize: vc.view.bounds.size)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 20, options: UIViewAnimationOptions.curveEaseOut, animations: {[unowned self] () -> Void in
            propImgV.bounds = CGRect(x: 0, y: 0, width: showSize.width, height: showSize.height)
            propImgV.center = self.vc.view.center
            self.view.alpha = 1
            }) { (complete) -> Void in
                propImgV.removeFromSuperview()
                self.collectionView.alpha = 1
        }
    }
    
    

    
    /** 关闭动画 */
    func zoomOutWithAnim(_ page: Int){
    
        let photoModel = photoModels[page]
        
        let cell = collectionView.cellForItem(at: IndexPath(item: page, section: 0)) as! ItemCell
        
        let cellImageView = cell.imageV
        
        let propImgV = UIImageView(frame: (cellImageView?.frame)!)
        propImgV.contentMode = UIViewContentMode.scaleAspectFill
        propImgV.clipsToBounds = true
        propImgV.image = !cell.hasHDImage && photoModel.hostThumbnailImg == nil ? UIImage.imageWithColor(size: CGSize(width: CFPBThumbNailWH, height: CFPBThumbNailWH)) : cellImageView?.image
        propImgV.frame = (cellImageView?.frame)!

        vc.view.addSubview(propImgV)
        
        cellImageView?.isHidden = true
        photoModel.sourceView.isHidden = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 20, options: UIViewAnimationOptions.curveEaseOut, animations: {[unowned self] () -> Void in
                self.view.alpha = 0
                propImgV.frame = photoModel.sourceView.convert(photoModel.sourceView.bounds, to: self.vc.view)
            
            }) { (complete) -> Void in
                
                photoModel.sourceView.isHidden = false
                propImgV.removeFromSuperview()
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        }
    
    }
    
}
