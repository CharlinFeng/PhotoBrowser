//
//  PhotoBrowser+CollectionView.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


extension PhotoBrowser: UICollectionViewDataSource,UICollectionViewDelegate{
    
    var cellID: String {return "ItemCell"}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        handleRotation(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleRotation(false)
        collectionView.isHidden = false
        let isZoomType = self.showType == PhotoBrowser.ShowType.zoomAndDismissWithCancelBtnClick || self.showType == PhotoBrowser.ShowType.zoomAndDismissWithSingleTap
        
        if self.photoType == PhotoType.local {
        
            collectionView.scrollToItem(at: IndexPath(item: showIndex, section: 0), at: UICollectionViewScrollPosition.left, animated: !isZoomType)
        
        }else{
         
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.1 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
                    
                    self.collectionView.scrollToItem(at: IndexPath(item: self.showIndex, section: 0), at: UICollectionViewScrollPosition.left, animated: !isZoomType)
            }
        }
    }

    
    /**  准备  */
    func collectionViewPrepare(){
        
        //添加
        self.view.addSubview(collectionView)
        collectionView.make_4Inset(inset: UIEdgeInsetsMake(0, 0, 0, -CFPBExtraWidth))

        //注册cell
        collectionView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        let isZoomType = self.showType == PhotoBrowser.ShowType.zoomAndDismissWithCancelBtnClick || self.showType == PhotoBrowser.ShowType.zoomAndDismissWithSingleTap
        
        if isZoomType {
            collectionView.isHidden = true
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(PhotoBrowser.handleRotation(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ItemCell
 
        itemCell.photoType = photoType
        
        itemCell.isHiddenBar = isHiddenBar
        
        itemCell.vc = vc
        
        let photoModel = photoModels[indexPath.row]
        
        photoModel.modelCell = itemCell
        
        itemCell.photoModel = photoModel
        
        itemCell.countLabel.text = "\(indexPath.row + 1) / \(photoModels.count)"
        
        if hideMsgForZoomAndDismissWithSingleTap && showType == .zoomAndDismissWithSingleTap {itemCell.toggleDisplayBottomBar(true)}
        
        return itemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let itemCell = cell as! ItemCell
        
        itemCell.reset()
    }

    
    func handleRotation(_ anim: Bool){
        
        DispatchQueue.main.async(execute: {[unowned self] () -> Void in
            
            let layout = Layout()
            
            layout.itemSize = self.view.bounds.size.sizeWithExtraWidth
            
            self.collectionView.setCollectionViewLayout(layout, animated: anim)
            
            self.collectionView.scrollToItem(at: IndexPath(item: self.page, section: 0), at: UICollectionViewScrollPosition.left, animated: false)
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        page = Int(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5)
    }
    
}

