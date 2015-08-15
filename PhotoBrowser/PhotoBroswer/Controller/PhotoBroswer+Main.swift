//
//  PhotoBroswer+Main.swift
//  PhotoBroswer
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


extension PhotoBroswer{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**  准备  */
        collectionViewPrepare()
        
        /**  控制器准备  */
        vcPrepare()
        
        self.edgesForExtendedLayout = UIRectEdge.None
        view.backgroundColor = UIColor.blackColor()
    }
    
    /**  控制器准备  */
    func vcPrepare(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "singleTapAction", name: CFPBSingleTapNofi, object: nil)
    
        if showType != PhotoBroswer.ShowType.ZoomAndDismissWithSingleTap {
            
            dismissBtn = UIButton(frame: CGRectMake(0, 0, 40, 40))
            dismissBtn.setBackgroundImage(UIImage(named: "pic.bundle/cancel"), forState: UIControlState.Normal)
            dismissBtn.addTarget(self, action: "dismissPrepare", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(dismissBtn)
        
            //保存按钮
            saveBtn = UIButton()
            saveBtn.setBackgroundImage(UIImage(named: "pic.bundle/save"), forState: UIControlState.Normal)
            saveBtn.addTarget(self, action: "saveAction", forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(saveBtn)
            saveBtn.make_rightTop_WH(top: 0, right: 0, rightWidth: 40, topHeight: 40)
        }
    }
    
    
    /** 保存 */
    func saveAction(){
        
        if contains(photoArchiverArr, page) {showHUD("已经保存", autoDismiss: 2); return}
        
        let itemCell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! ItemCell
        
        if itemCell.imageV.image == nil {showHUD("图片未下载", autoDismiss: 2); return}
        
        showHUD("保存中", autoDismiss: -1)
        
        //当前模型
        let savePhotoModel = photoModels[page]

        UIImageWriteToSavedPhotosAlbum(itemCell.imageV.image, self, Selector("image:didFinishSavingWithError:contextInfo:"), nil)
        
        self.view.userInteractionEnabled = false
    }

    /** come on */
    func image(image: UIImage, didFinishSavingWithError: NSError, contextInfo:UnsafePointer<Void>){
        
        self.view.userInteractionEnabled = true
        
        if let error = didFinishSavingWithError as NSError? {
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
        
        if showType != PhotoBroswer.ShowType.ZoomAndDismissWithSingleTap {
        
            isHiddenBar = !isHiddenBar
            
            dismissBtn.hidden = isHiddenBar
            saveBtn.hidden = isHiddenBar
            
            //取出cell
            let cell = collectionView.cellForItemAtIndexPath(NSIndexPath(forItem: page, inSection: 0)) as! ItemCell
            cell.toggleDisplayBottomBar(isHiddenBar)
            
        }else{
           
            dismissPrepare()
        }
        
        
    }
    
    
    func dismissAction(isZoomType: Bool){
        
        UIApplication.sharedApplication().statusBarHidden = isStatusBarHidden
        
        if vc.navigationController != nil {vc.navigationController?.navigationBarHidden = isNavBarHidden}
        if vc.tabBarController != nil {vc.tabBarController?.tabBar.hidden = isTabBarHidden}
        
        if showType == .Push || showType == .Modal {return}
        
        /** 关闭动画 */
        zoomOutWithAnim(page)
        
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: CFPBShowKey)
    }
    
    
    func dismissPrepare(){
        
        if showType == .Push{
            
            self.navigationController?.popViewControllerAnimated(true)
            
            dismissAction(false)
            
        }else if showType == .Modal{
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
            dismissAction(false)
            
        } else if showType == ShowType.ZoomAndDismissWithSingleTap{
            
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
        
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: CFPBShowKey)
        
        isStatusBarHidden = UIApplication.sharedApplication().statusBarHidden
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        //记录index
        showIndex = index
        
        //记录
        self.vc = vc
        
        let navVC = vc.navigationController
        
        if vc.navigationController != nil { isNavBarHidden = vc.navigationController?.navigationBarHidden}
        if vc.tabBarController != nil { isTabBarHidden = vc.tabBarController?.tabBar.hidden}
        
        navVC?.navigationBarHidden = true
        vc.tabBarController?.tabBar.hidden = true
        
        if showType == .Push{//push
            
            vc.hidesBottomBarWhenPushed = true
            vc.navigationController?.pushViewController(self, animated: true)
            
        }else if showType == .Modal{
            
            vc.presentViewController(self, animated: true, completion: nil)
            
        }else{
            
            //添加子控制器
            vc.view.addSubview(self.view)
            
            //添加约束
            self.view.make_4Insets(insets: UIEdgeInsetsZero)
            
            vc.addChildViewController(self)
            
            let showPhotoModel = photoModels[index]
            
            /** 展示动画 */
            zoomInWithAnim(index)
            
            if showType == PhotoBroswer.ShowType.ZoomAndDismissWithSingleTap && hideMsgForZoomAndDismissWithSingleTap {
            
                /** pagecontrol准备 */
                pagecontrolPrepare()
                pagecontrol.currentPage = index
            }
        }
    }
    
    
}