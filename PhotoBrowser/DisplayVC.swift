//
//  DisplayVC.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class DisplayVC: UIViewController {
    
    
    var langType: LangType = LangType.chinese
    
    var photoType: PhotoType = PhotoType.local
    
    var showType: PhotoBrowser.ShowType = PhotoBrowser.ShowType.zoomAndDismissWithSingleTap

    lazy var localImages: [String] = {["1.jpg","2.jpg","3.jpg","4.jpg","5.jpg","6.jpg","7.jpg","8.jpg","9.jpg"]}()

    let displayView = DisplayView()
    
    lazy var hostThumbNailImageUrls: [String] = {
        
        return [
            
            "http://ios-android.cn/PB/ThumbNail/1.jpg",
            "http://ios-android.cn/PB/ThumbNail/2.jpg",
            "http://ios-android.cn/PB/ThumbNail/3.jpg",
            "http://ios-android.cn/PB/ThumbNail/4.jpg",
            "http://ios-android.cn/PB/ThumbNail/5.jpg",
            "http://ios-android.cn/PB/ThumbNail/6.jpg",
            "http://ios-android.cn/PB/ThumbNail/7.jpg",
            "http://ios-android.cn/PB/ThumbNail/8.jpg",
            "http://ios-android.cn/PB/ThumbNail/9.jpg",
        ]
    }()
    
}




extension DisplayVC{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.title = langType == LangType.chinese ? "照片浏览器终结者" : "Photo Browser Terminator"

        if photoType == PhotoType.local { //本地
            displayView.imgsPrepare(localImages, isLocal: true)
        }else{ //网络
            displayView.imgsPrepare(hostThumbNailImageUrls, isLocal: false)
        }
        view.addSubview(displayView)
        
        let wh = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        
        displayView.make_center(offsest: CGPoint.zero, width: wh, height: wh)
        
        
        displayView.tapedImageV = {[unowned self] index in
        
            if self.photoType == PhotoType.local { //本地
                self.showLocal(index)
            }else{ //网络
                self.showHost(index)
            }
        }
    }
    
    
}
