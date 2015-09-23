//
//  DisplayView.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class DisplayView: UIView {

    
    var tapedImageV: ((index: Int)->())?
    
}


extension DisplayView{
    
    /** 准备 */
    func imgsPrepare(imgs: [String], isLocal: Bool){
       
        for (var i=0; i<imgs.count; i++){
            
            let imgV = UIImageView(frame: CGRectMake(0, 0, 200, 200))
            imgV.backgroundColor = UIColor.lightGrayColor()
            imgV.userInteractionEnabled = true
            imgV.contentMode = UIViewContentMode.ScaleAspectFill
            imgV.clipsToBounds = true
            imgV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapAction:"))
            imgV.tag = i
            if isLocal {
                imgV.image = UIImage(named: imgs[i])
            }else{
                imgV.hnk_setImageFromURL(NSURL(string: imgs[i])!)
            }
            self.addSubview(imgV)
        }
    }
    
    
    func tapAction(tap: UITapGestureRecognizer){
        tapedImageV?(index: tap.view!.tag)
    }
    
    
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let totalRow = 3
        let totalWidth = self.bounds.size.width
        
        let margin: CGFloat = 10
        let itemWH = (totalWidth - margin * CGFloat(totalRow + 1)) / CGFloat(totalRow)
        
        /** 数组遍历 */
        var i=0
        
        for view in self.subviews{

            let row = i / totalRow
            let col = i % totalRow
            
            let x = (CGFloat(col) + 1) * margin + CGFloat(col) * itemWH
            let y = (CGFloat(row) + 1) * margin + CGFloat(row) * itemWH
            let frame = CGRectMake(x, y, itemWH, itemWH)
            view.frame = frame
            i++
        }
    }
}