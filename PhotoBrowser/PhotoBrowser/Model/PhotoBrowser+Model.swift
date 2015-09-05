//
//  CFPhotoBroserVC+Model.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/8/10.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

extension PhotoBrowser{
    
    class PhotoModel{
        
        /**  本地相册模式下的本地相册数据  */
        var localImg: UIImage!
        
        /** 网络相册模式下的网络相册URL地址 */
        /** 高清 */
        var hostHDImgURL: String!
        
        /** 缩略图 */
        var hostThumbnailImg: UIImage!
        
        /**  标题  */
        var titleStr: String!
        
        /**  详细说明文字  */
        var descStr: String!
        
        /**  源ImageView: zoom模式需要传  */
        var sourceView: UIView!
        
        var isLocal: Bool!
        
        /**  暴力去除异常  */
        var excetionFlag = false
        
        /**  由于hanake有bug，增加此属性  */
        var modelCell: UICollectionViewCell!
        
        /**  本地相册专业初始化方法  */
        init(localImg: UIImage!, titleStr: String!, descStr: String!, sourceView: UIView!){
            
            self.isLocal = true
            
            self.localImg = localImg
            self.titleStr = titleStr
            self.descStr = descStr
            self.sourceView = sourceView
            excetionFlag = true
        }
        
        
        /**  本地相册专业初始化方法  */
        init(hostHDImgURL: String!, hostThumbnailImg: UIImage!, titleStr: String!, descStr: String!, sourceView: UIView!){
            
            self.isLocal = false
    
            self.hostHDImgURL = hostHDImgURL
            self.hostThumbnailImg = hostThumbnailImg
            self.titleStr = titleStr
            self.descStr = descStr
            self.sourceView = sourceView
            excetionFlag = true
        }
        
    }
}
