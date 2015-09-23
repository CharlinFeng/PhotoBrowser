//
//  PhotoBrowser.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class PhotoBrowser: UIViewController {
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: Layout())

    /**  展示样式：请设置  */
    var showType: ShowType!
    
    /**  相册类型：请设置  */
    var photoType: PhotoType!
    
    /**  相册数据  */
    var photoModels: [PhotoModel]!{didSet{collectionView.reloadData()}}
    
    /**  强制关闭一切信息显示: 仅仅针对ZoomAndDismissWithSingleTap模式有效  */
    var hideMsgForZoomAndDismissWithSingleTap: Bool = false
    
    lazy var pagecontrol = UIPageControl()
    
    var page: Int = 0 {didSet{pageControlPageChanged(page)}}
    
    weak var vc: UIViewController!
    
    var isNavBarHidden: Bool!
    var isTabBarHidden: Bool!
    var isStatusBarHidden: Bool!
    
    var showIndex: Int = 0
    
    var dismissBtn,saveBtn: UIButton!
    var isHiddenBar: Bool = false
    
    lazy var photoArchiverArr: [Int] = []

    deinit{NSNotificationCenter.defaultCenter().removeObserver(self);print("deinit")}
    
    lazy var hud: UILabel = {
        
        let hud = UILabel()
        hud.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        hud.textColor = UIColor.whiteColor()
        hud.alpha = 0
        hud.textAlignment = NSTextAlignment.Center
        hud.layer.cornerRadius = 5
        hud.layer.masksToBounds = true
        return hud
    }()
}
