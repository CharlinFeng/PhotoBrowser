//
//  PhotoBrowser+PBType.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/8/2.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


extension PhotoBrowser{
    
    /**  展示样式  */
    enum ShowType{
        
        /**  push展示：网易新闻  */
        case Push
        
        /**  modal展示：可能有需要  */
        case Modal
        
        /**  frame放大模式：单击相册可关闭 */
        case ZoomAndDismissWithSingleTap
        
        /**  frame放大模式：点击按钮可关闭 */
        case ZoomAndDismissWithCancelBtnClick
    }
    
    
    /**  相册类型  */
    enum PhotoType{
        
        /**  本地相册  */
        case Local
        
        /**  服务器相册  */
        case Host
    }

}