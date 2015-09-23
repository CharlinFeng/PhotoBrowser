//
//  Layout.swift
//  PhotoBrowser
//
//  Created by 成林 on 15/7/29.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

extension PhotoBrowser{
    
    
    class Layout: UICollectionViewFlowLayout {
    
        override init(){
            
            super.init()
            
            /**  配置  */
            layoutSetting()
        }

        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
        }
        
        /**  配置  */
        func layoutSetting(){

            let size = UIScreen.mainScreen().bounds.size
            self.itemSize = size.sizeWithExtraWidth
            
            self.minimumInteritemSpacing = 0
            self.minimumLineSpacing = 0
            self.sectionInset = UIEdgeInsetsZero
            self.scrollDirection = UICollectionViewScrollDirection.Horizontal
        }
        
    }
    
    
    
}