//
//  CFPhotoBroserVC+Common.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/8/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit

let CFPBExtraWidth: CGFloat = 20
let CFPBThumbNailWH: CGFloat = 120

let CFPBSingleTapNofi = "CFPBSingleTapNofi"
let CFPBDismissBtnClickNoti = "CFPBDismissBtnClickNoti"
let PhotoBrowserDidShowNoti = "PhotoBrowserDidShowNoti"
let PhotoBrowserDidDismissNoti = "PhotoBrowserDidDismissNoti"
let CFPBShowKey = "CFPBShowKey"
let CFPBCacheKey = "CFPBCacheKey"

extension CGSize{
    
    var sizeWithExtraWidth: CGSize {return CGSizeMake(self.width + CFPBExtraWidth, self.height)}
    
    var sizeMinusExtraWidth: CGSize {return CGSizeMake(self.width - CFPBExtraWidth, self.height)}
    
    /** 按比例缩放 */
    func ratioSize(ratio: CGFloat) -> CGSize{
    
        return CGSizeMake(self.width / ratio, self.height / ratio) }
    
    static func decisionShowSize(imgSize: CGSize, contentSize: CGSize) ->CGSize{
        
        let heightRatio = imgSize.height / contentSize.height
        let widthRatio = imgSize.width / contentSize.width
        
        if heightRatio > 1 && widthRatio>1 {return imgSize.ratioSize(max(heightRatio, widthRatio))}
        
        if heightRatio > 1 && widthRatio <= 1 {return imgSize.ratioSize(heightRatio)}
        
        if heightRatio <= 1 && widthRatio > 1 {return imgSize.ratioSize(widthRatio)}
        
        if heightRatio <= 1 && widthRatio <= 1 {return imgSize.ratioSize(max(heightRatio, widthRatio))}
        
        return imgSize
    }
}

extension UIView{
    
    /** Debug */
    func debug(color: UIColor = UIColor.redColor(), borderWidth: CGFloat = 5){
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = borderWidth
    }

}



extension UIImage{
    
    /** 源于色彩的UIImage，可自定义size */
    class func imageWithColor(color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1), size: CGSize = CGSizeMake(1, 1)) -> UIImage{
        
        let rect = CGRectMake(0, 0, size.width, size.height)
        
        //开启一个图形上下文
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        //获取图形上下文
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        
        CGContextFillRect(context, rect)
        
        //获取图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext();
        
        return image;
    }
}



