//
//  PhotoBrowser+Main.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


extension PhotoBrowser{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**  准备  */
        collectionViewPrepare()
        
        /**  控制器准备  */
        vcPrepare()
        
        self.edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = UIColor.black
    }
    
    /**  控制器准备  */
    func vcPrepare(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(PhotoBrowser.singleTapAction), name: NSNotification.Name(rawValue: CFPBSingleTapNofi), object: nil)
    
        if showType != PhotoBrowser.ShowType.zoomAndDismissWithSingleTap {
            
            dismissBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            dismissBtn.setBackgroundImage(UIImage(named: "pic.bundle/cancel"), for: UIControlState())
            dismissBtn.addTarget(self, action: #selector(PhotoBrowser.dismissPrepare), for: UIControlEvents.touchUpInside)
            self.view.addSubview(dismissBtn)
        
            //保存按钮
            saveBtn = UIButton()
            saveBtn.setBackgroundImage(UIImage(named: "pic.bundle/save"), for: UIControlState())
            saveBtn.addTarget(self, action: #selector(PhotoBrowser.saveAction), for: UIControlEvents.touchUpInside)
            self.view.addSubview(saveBtn)
            saveBtn.make_rightTop_WH(top: 0, right: 0, rightWidth: 40, topHeight: 40)
        }
    }
    
    
    /** 保存 */
    func saveAction(){
        
        if photoArchiverArr.contains(page) {showHUD("已经保存", autoDismiss: 2); return}
        
        let itemCell = collectionView.cellForItem(at: IndexPath(item: page, section: 0)) as! ItemCell
        
        if itemCell.imageV.image == nil {showHUD("图片未下载", autoDismiss: 2); return}
        
        if !itemCell.hasHDImage {showHUD("图片未下载", autoDismiss: 2); return}
        
        showHUD("保存中", autoDismiss: -1)
    
        UIImageWriteToSavedPhotosAlbum(itemCell.imageV.image!, self, #selector(PhotoBrowser.image(_:didFinishSavingWithError:contextInfo:)), nil)
        
        self.view.isUserInteractionEnabled = false
    }

    /** come on */
    func image(_ image: UIImage, didFinishSavingWithError: NSError, contextInfo:UnsafeRawPointer){
     
        self.view.isUserInteractionEnabled = true
        
        if (didFinishSavingWithError as NSError?) == nil {
            showHUD("保存失败", autoDismiss: 2)
        }
        else{
            showHUD("保存成功", autoDismiss: 2)
            
            //记录
            photoArchiverArr.append(page)
        }
    }
    
    
    /**  单击事件  */
    func singleTapAction(){
        
        if showType != PhotoBrowser.ShowType.zoomAndDismissWithSingleTap {
        
            isHiddenBar = !isHiddenBar
            
            dismissBtn.isHidden = isHiddenBar
            saveBtn.isHidden = isHiddenBar
            
            //取出cell
            let cell = collectionView.cellForItem(at: IndexPath(item: page, section: 0)) as! ItemCell
            cell.toggleDisplayBottomBar(isHiddenBar)
            
        }else{
           
            dismissPrepare()
        }
        
        
    }
    
    
    func dismissAction(_ isZoomType: Bool){
        
        UIApplication.shared.isStatusBarHidden = isStatusBarHidden
        
        if vc.navigationController != nil {vc.navigationController?.isNavigationBarHidden = isNavBarHidden}
        if vc.tabBarController != nil {vc.tabBarController?.tabBar.isHidden = isTabBarHidden}
        
        if showType == ShowType.push || showType == ShowType.modal {return}
        
        /** 关闭动画 */
        zoomOutWithAnim(page)
        
        UserDefaults.standard.set(false, forKey: CFPBShowKey)
        NotificationCenter.default.post(name: Notification.Name(rawValue: PhotoBrowserDidDismissNoti), object: self)
    }
    
    
    func dismissPrepare(){
        
        if showType == .push{
            
            self.navigationController?.popViewController(animated: true)
            
            dismissAction(false)
            
        }else if showType == .modal{
            
            self.dismiss(animated: true, completion: nil)
            
            dismissAction(false)
            
        } else if showType == ShowType.zoomAndDismissWithSingleTap{
            
            dismissAction(true)
            
        }else{
            
            dismissAction(true)
        }
    }
    
    func show(inVC vc: UIViewController,index: Int){
        assert(showType != nil, "Error: You Must Set showType!")
        assert(photoType != nil, "Error: You Must Set photoType!")
        assert(photoModels != nil, "Error: You Must Set DataModels!")
        assert(index <= photoModels.count - 1, "Error: Index is Out of DataModels' Boundary!")
        
        UserDefaults.standard.set(true, forKey: CFPBShowKey)
        
        isStatusBarHidden = UIApplication.shared.isStatusBarHidden
        
        UIApplication.shared.isStatusBarHidden = true
        
        //记录index
        showIndex = index
        
        //记录
        self.vc = vc
        
        let navVC = vc.navigationController
        
        if vc.navigationController != nil { isNavBarHidden = vc.navigationController?.isNavigationBarHidden}
        if vc.tabBarController != nil { isTabBarHidden = vc.tabBarController?.tabBar.isHidden}
        
        navVC?.isNavigationBarHidden = true
        vc.tabBarController?.tabBar.isHidden = true
        
        if showType == .push{//push
            
            vc.hidesBottomBarWhenPushed = true
            vc.navigationController?.pushViewController(self, animated: true)
            
        }else if showType == .modal{
            
            vc.present(self, animated: true, completion: nil)
            
        }else{
            
            //添加子控制器
            vc.view.addSubview(self.view)
            
            //添加约束
            self.view.make_4Inset(inset: UIEdgeInsets.zero)
            
            vc.addChildViewController(self)
            
            /** 展示动画 */
            zoomInWithAnim(index)
            
            if showType == PhotoBrowser.ShowType.zoomAndDismissWithSingleTap && hideMsgForZoomAndDismissWithSingleTap {
            
                /** pagecontrol准备 */
                pagecontrolPrepare()
                pagecontrol.currentPage = index
            }
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: PhotoBrowserDidShowNoti), object: self)
    
    }
    
    
}
