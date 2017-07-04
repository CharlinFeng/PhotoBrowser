//
//  DisplayView.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class DisplayView: UIView {

    
    var tapedImageV: ((_ index: Int)->())?
    
}


extension DisplayView{
    
    /** 准备 */
    func imgsPrepare(_ imgs: [String], isLocal: Bool){
       
        for i in 0 ..< imgs.count {
            
            let imgV = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
            imgV.backgroundColor = UIColor.lightGray
            imgV.isUserInteractionEnabled = true
            imgV.contentMode = UIViewContentMode.scaleAspectFill
            imgV.clipsToBounds = true
            imgV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(DisplayView.tapAction(_:))))
            imgV.tag = i
            if isLocal {
                imgV.image = UIImage(named: imgs[i])
            }else{
                imgV.hnk_setImageFromURL(URL(string: imgs[i])!)
            }
            self.addSubview(imgV)
        }
    }
    
    
    func tapAction(_ tap: UITapGestureRecognizer){
        tapedImageV?(tap.view!.tag)
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
            let frame = CGRect(x: x, y: y, width: itemWH, height: itemWH)
            view.frame = frame
            i += 1
        }
    }
}
