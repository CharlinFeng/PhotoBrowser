//
//  CFSnapKit.swift
//  CFSnapKit
//
//  Created by 成林 on 15/6/22.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    
    /**  四边内边距  */
    func make_4Insets(#insets: UIEdgeInsets){
        
        if self.superview == nil {return}
            
        self.snp_makeConstraints{ (make) -> Void in
            make.edges.equalTo(self.superview!).insets(insets)
        }
    }
    
    /**  顶部内边距 + 高度  */
    func make_topInsets_topHeight(#top: CGFloat, left: CGFloat, right: CGFloat, topHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp_top).offset(top)
            make.leading.equalTo(sv!.snp_leading).offset(left)
            make.trailing.equalTo(sv!.snp_trailing).offset(-right)
            make.height.equalTo(topHeight)
        }
    }
    
    
    /**  左侧内边距 + 宽度  */
    func make_leftInsets_leftWidth(#top: CGFloat, left: CGFloat, bottom: CGFloat, leftWidth: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp_top).offset(top)
            make.leading.equalTo(sv!.snp_leading).offset(left)
            make.bottom.equalTo(sv!.snp_bottom).offset(-bottom)
            make.width.equalTo(leftWidth)
        }
    }
    
    
    /**  底部内边距 + 高度  */
    func make_bottomInsets_bottomHeight(#left: CGFloat, bottom: CGFloat, right: CGFloat, bottomHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.leading.equalTo(sv!.snp_leading).offset(left)
            make.bottom.equalTo(sv!.snp_bottom).offset(-bottom)
            make.trailing.equalTo(sv!.snp_trailing).offset(-right)
            make.height.equalTo(bottomHeight)
        }
    }
    
    
    /**  右侧内边距 + 宽度  */
    func make_rightInsets_rightWidth(#bottom: CGFloat, right: CGFloat, top: CGFloat, rightWidth: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp_top).offset(top)
            make.bottom.equalTo(sv!.snp_bottom).offset(-bottom)
            make.trailing.equalTo(sv!.snp_trailing).offset(-right)
            make.width.equalTo(rightWidth)
        }
    }
    

    /**  左上角 + 宽度 + 高度  */
    func make_leftTop_WH(#top: CGFloat, left: CGFloat, leftWidth: CGFloat, topHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp_top).offset(top)
            make.leading.equalTo(sv!.snp_leading).offset(left)
            make.width.equalTo(leftWidth)
            make.height.equalTo(topHeight)
        }
    }

    
    /**  右上角 + 宽度 + 高度  */
    func make_rightTop_WH(#top: CFloat, right: CGFloat, rightWidth: CGFloat, topHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp_top).offset(top)
            make.trailing.equalTo(sv!.snp_trailing).offset(-right)
            make.width.equalTo(rightWidth)
            make.height.equalTo(topHeight)
        }
    }

    
    /**  左下角 + 宽度 + 高度  */
    func make_leftBottom_WH(#left: CGFloat, bottom: CGFloat, leftWidth: CGFloat, bottomHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.leading.equalTo(sv!.snp_leading).offset(left)
            make.bottom.equalTo(sv!.snp_bottom).offset(-bottom)
            make.width.equalTo(leftWidth)
            make.height.equalTo(bottomHeight)
        }
    }
    

    /**  右下角 + 宽度 + 高度  */
    func make_rightBottom(#bottom: CGFloat, right: CGFloat, rightWidth: CGFloat, bottomHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.trailing.equalTo(sv!.snp_trailing).offset(-right)
            make.bottom.equalTo(sv!.snp_bottom).offset(-bottom)
            make.width.equalTo(rightWidth)
            make.height.equalTo(bottomHeight)
        }
    }
    
    
    /**  中点 + 偏移 + 大小  */
    func make_center(offsest: CGPoint, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.center.equalTo(sv!.snp_center).offset(offsest)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    
    /** 顶部居中 + 宽高 */
    func make_top_WH(#top: CGFloat, offsetX: CGFloat, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.centerX.equalTo(sv!.snp_centerX).offset(offsetX)
            make.top.equalTo(sv!.snp_top).offset(top)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    
    /** 左侧居中 + 宽高 */
    func make_left_WH(#left: CGFloat, offsetY: CGFloat, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.centerY.equalTo(sv!.snp_centerY).offset(offsetY)
            make.leading.equalTo(sv!.snp_leading).offset(left)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    /** 底部居中 + 宽高 */
    func make_bottom_WH(#bottom: CGFloat, offsetX: CGFloat, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.centerX.equalTo(sv!.snp_centerX).offset(offsetX)
            make.bottom.equalTo(sv!.snp_bottom).offset(-bottom)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    
    /** 右侧居中 + 宽高 */
    func make_right_WH(#right: CGFloat, offsetY: CGFloat, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp_makeConstraints{ (make) -> Void in
            
            make.centerY.equalTo(sv!.snp_centerY).offset(offsetY)
            make.trailing.equalTo(sv!.snp_trailing).offset(-right)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    
    
    
}
