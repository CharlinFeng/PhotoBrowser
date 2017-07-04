//
//  DisplayVC+Host.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


extension DisplayVC{
    
    var hostHDImageUrls: [String] {
    
        return [
        
            "http://ios-android.cn/PB/HD/1.jpg",
            "http://ios-android.cn/PB/HD/2.jpg",
            "http://ios-android.cn/PB/HD/3.jpg",
            "http://ios-android.cn/PB/HD/4.jpg",
            "http://ios-android.cn/PB/HD/5.jpg",
            "http://ios-android.cn/PB/HD/6.jpg",
            "http://ios-android.cn/PB/HD/7.jpg",
            "http://ios-android.cn/PB/HD/8.jpg",
            "http://ios-android.cn/PB/HD/9.jpg",
        ]
    }
    
    
    var titleHostCH: [String] {
        return [
            "漫山遍野的牦牛正在吃草",
            "起伏的山峦",
            "月亮湾",
            "框架作者：成都.冯成林",
            "凌晨",
            "大草原",
            "三朵金花",
            "水鬼",
            "若尔盖花湖",
        ]
    }
    
    
    var titleHostEN: [String] {
        return [
            "The yak grazing all over the mountains and plains",
            "Rolling hills",
            "Moon Bay",
            "Frame Author: Chengdu Charlin Feng",
            "Early in the morning",
            "Prairie",
            "Three golden flowers",
            "Kelpy",
            "Ruoergai Lake",
        ]
    }
    
    
    var descHostCH: [String] {
        return [
            "作为世界三大高寒动物之一,牦牛肉被誉为牛肉之冠",
            "有一种win xp的壁纸的感觉，这里是没有树木的，因为海拔的原因",
            "红原月亮湾风景区位于红原县城3公里处的安曲牧场；距离若尔盖县城142公里。",
            "",
            "这个是凌晨的照片，天空中的是明月",
            "这里是一望无际的大草原，非常辽阔",
            "三朵金花啊",
            "黑夜水鬼，正迎面扑来",
            "花湖位于若尔盖和甘肃郎木寺之间的213国道旁，热尔大坝上有3个相邻的海子，最小的叫错尔干，最大的叫错热哈，花湖是居中的一个。若尔盖花湖四周数百亩水草地就是高原湿地生物多样性自然保护区",
        ]
    }

    
    var descHostEN: [String] {
        return [
            "As one of the world's three largest alpine animals, yak meat is known as the crown of beef",
            "There is a feeling of XP win's wallpaper, there is no trees, because of the reasons above sea level",
            "Red Moon Bay scenic area is located in the county 3 kilometers in an Qu pasture; 142 kilometers from the Ruoergai county.",
            "",
            "This is the morning of the photo, the sky is the moon",
            "Here is a very vast prairie stretch as far as eye can see,",
            "Three golden flowers.",
            "The night is coming home,",
            "Lake is located in the Zoige and Gansu Langmusi between 213 national highway, gers dam has three adjacent Haizi, minimum call wrong Durkheim, largest called wrong hot ha, Kusum is in the middle of a. Ruoergai lake water is around hundreds of acres of grassland biodiversity of the plateau wetland biological nature reserve",
        ]
    }

    
    
    
    
    /** 网络相册相册 */
    func showHost(_ index: Int){
        
        
        let pbVC = PhotoBrowser()
        
        /**  设置相册展示样式  */
        pbVC.showType = showType
        
        /**  设置相册类型  */
        pbVC.photoType = PhotoBrowser.PhotoType.host
        
        //强制关闭显示一切信息
        pbVC.hideMsgForZoomAndDismissWithSingleTap = true
        
        var models: [PhotoBrowser.PhotoModel] = []
        
        let titles = langType == LangType.chinese ? titleHostCH : titleHostEN
        let descs = langType == LangType.chinese ? descHostCH : descHostEN
        
        //模型数据数组
        for i in 0 ..< 9 {
            
            let model = PhotoBrowser.PhotoModel(hostHDImgURL: hostHDImageUrls[i], hostThumbnailImg: (displayView.subviews[i] as! UIImageView).image, titleStr: titles[i], descStr: descs[i], sourceView: displayView.subviews[i])

            models.append(model)
        }
        
        /**  设置数据  */
        pbVC.photoModels = models
        
        pbVC.show(inVC: self,index: index)
    }

    
    
}
