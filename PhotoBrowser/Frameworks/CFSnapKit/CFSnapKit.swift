//
//  CFSnapKit.swift
//  CFSnapKit
//
//  Created by 成林 on 15/6/22.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit

/** 
 *  You must add -DSNAPKIT_DEPLOYMENT_LEGACY to your OTHER_SWIFT_FLAGS in your targets Build Settings. 
 */

extension UIView {
    
    /**  四边内边距  */
    func make_4Inset(inset: UIEdgeInsets){
        
        if self.superview == nil {return}

        self.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(self.superview!).inset(inset)
        }
    }
    
    /**  顶部内边距 + 高度  */
    func make_topInsets_topHeight(top: CGFloat, left: CGFloat, right: CGFloat, topHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp.top).offset(top)
            make.leading.equalTo(sv!.snp.leading).offset(left)
            make.trailing.equalTo(sv!.snp.trailing).offset(-right)
            make.height.equalTo(topHeight)
        }
    }
    
    
    /**  左侧内边距 + 宽度  */
    func make_leftInsets_leftWidth(top: CGFloat, left: CGFloat, bottom: CGFloat, leftWidth: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp.top).offset(top)
            make.leading.equalTo(sv!.snp.leading).offset(left)
            make.bottom.equalTo(sv!.snp.bottom).offset(-bottom)
            make.width.equalTo(leftWidth)
        }
    }
    
    
    /**  底部内边距 + 高度  */
    func make_bottomInsets_bottomHeight(left: CGFloat, bottom: CGFloat, right: CGFloat, bottomHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.leading.equalTo(sv!.snp.leading).offset(left)
            make.bottom.equalTo(sv!.snp.bottom).offset(-bottom)
            make.trailing.equalTo(sv!.snp.trailing).offset(-right)
            make.height.equalTo(bottomHeight)
        }
    }
    
    
    /**  右侧内边距 + 宽度  */
    func make_rightInsets_rightWidth(bottom: CGFloat, right: CGFloat, top: CGFloat, rightWidth: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp.top).offset(top)
            make.bottom.equalTo(sv!.snp.bottom).offset(-bottom)
            make.trailing.equalTo(sv!.snp.trailing).offset(-right)
            make.width.equalTo(rightWidth)
        }
    }
    

    /**  左上角 + 宽度 + 高度  */
    func make_leftTop_WH(top: CGFloat, left: CGFloat, leftWidth: CGFloat, topHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp.top).offset(top)
            make.leading.equalTo(sv!.snp.leading).offset(left)
            make.width.equalTo(leftWidth)
            make.height.equalTo(topHeight)
        }
    }

    
    /**  右上角 + 宽度 + 高度  */
    func make_rightTop_WH(top: CFloat, right: CGFloat, rightWidth: CGFloat, topHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.top.equalTo(sv!.snp.top).offset(top)
            make.trailing.equalTo(sv!.snp.trailing).offset(-right)
            make.width.equalTo(rightWidth)
            make.height.equalTo(topHeight)
        }
    }

    
    /**  左下角 + 宽度 + 高度  */
    func make_leftBottom_WH(left: CGFloat, bottom: CGFloat, leftWidth: CGFloat, bottomHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.leading.equalTo(sv!.snp.leading).offset(left)
            make.bottom.equalTo(sv!.snp.bottom).offset(-bottom)
            make.width.equalTo(leftWidth)
            make.height.equalTo(bottomHeight)
        }
    }
    

    /**  右下角 + 宽度 + 高度  */
    func make_rightBottom(bottom: CGFloat, right: CGFloat, rightWidth: CGFloat, bottomHeight: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.trailing.equalTo(sv!.snp.trailing).offset(-right)
            make.bottom.equalTo(sv!.snp.bottom).offset(-bottom)
            make.width.equalTo(rightWidth)
            make.height.equalTo(bottomHeight)
        }
    }
    
    
    /**  中点 + 偏移 + 大小  */
    func make_center(offsest: CGPoint, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.centerX.equalTo(sv!.snp.centerX).offset(offsest.x)
            make.centerY.equalTo(sv!.snp.centerY).offset(offsest.y)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    
    /** 顶部居中 + 宽高 */
    func make_top_WH(top: CGFloat, offsetX: CGFloat, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.centerX.equalTo(sv!.snp.centerX).offset(offsetX)
            make.top.equalTo(sv!.snp.top).offset(top)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    
    /** 左侧居中 + 宽高 */
    func make_left_WH(left: CGFloat, offsetY: CGFloat, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.centerY.equalTo(sv!.snp.centerY).offset(offsetY)
            make.leading.equalTo(sv!.snp.leading).offset(left)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    /** 底部居中 + 宽高 */
    func make_bottom_WH(bottom: CGFloat, offsetX: CGFloat, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.centerX.equalTo(sv!.snp.centerX).offset(offsetX)
            make.bottom.equalTo(sv!.snp.bottom).offset(-bottom)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    
    /** 右侧居中 + 宽高 */
    func make_right_WH(right: CGFloat, offsetY: CGFloat, width: CGFloat, height: CGFloat){
        
        let sv = self.superview
        
        if sv == nil {return}
        
        self.snp.makeConstraints{ (make) -> Void in
            
            make.centerY.equalTo(sv!.snp.centerY).offset(offsetY)
            make.trailing.equalTo(sv!.snp.trailing).offset(-right)
            make.width.equalTo(width)
            make.height.equalTo(height)

        }
    }
    
    
    
    /** 宽度约束 */
    func make_width(equal: CGFloat) {

        self.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(equal)
        }
    }
    
    /** 高度约束 */
    func make_height(equal: CGFloat) {
        
        self.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(equal)
        }
    }
    
    

    /**
    多个View之间的单条约束
    
    :param: sd self.direction
    :param: v  view
    :param: vdEnum view.direction
    :param: o  offsetValue
    */
    func make_relation(sd: Int, v: UIView!, vd: Int, o: CGFloat) -> ConstraintMakerEditable!{

        if superview == nil {return nil}
        
        let relationView = v ?? superview!

        var c: ConstraintMakerEditable! = nil
    
        let sdEnum = Direction(rawValue: sd)
        let vdEnum = Direction(rawValue: vd)

        if sdEnum == .Top {
            
            if vdEnum == .Top {
                
                self.snp.makeConstraints({ (make) -> Void in
                    c = make.top.equalTo(relationView.snp.top).offset(o)
                })
                
            }else if vdEnum == .Left {
                
                self.snp.makeConstraints( { (make) -> Void in
                    c = make.top.equalTo(relationView.snp.leading).offset(o)
                })
                
            }else if vdEnum == .Bottom {
                
                self.snp.makeConstraints( { (make) -> Void in
                    c = make.top.equalTo(relationView.snp.bottom).offset(-o)
                })
            }else if vdEnum == .Right {
                
                self.snp.makeConstraints({ (make) -> Void in
                    c = make.top.equalTo(relationView.snp.trailing).offset(-o)
                })
            }
            
        }else if sdEnum == .Left {
            
            if vdEnum == .Top {
                
                self.snp.makeConstraints( { (make) -> Void in
                    c = make.leading.equalTo(relationView.snp.top).offset(o)
                })
                
            }else if vdEnum == .Left {
                
                self.snp.makeConstraints( { (make) -> Void in
                    c = make.leading.equalTo(relationView.snp.leading).offset(o)
                })
                
            }else if vdEnum == .Bottom {
                
                self.snp.makeConstraints({ (make) -> Void in
                    c = make.leading.equalTo(relationView.snp.bottom).offset(-o)
                })
                
            }else if vdEnum == .Right {
                
                self.snp.makeConstraints( { (make) -> Void in
                    c = make.leading.equalTo(relationView.snp.trailing).offset(-o)
                })
            }
        }else if sdEnum == .Bottom {
            
            if vdEnum == .Top {
                
                self.snp.makeConstraints( { (make) -> Void in
                    c = make.bottom.equalTo(relationView.snp.top).offset(o)
                })
                
            }else if vdEnum == .Left {
                
                self.snp.makeConstraints({ (make) -> Void in
                    c = make.bottom.equalTo(relationView.snp.leading).offset(o)
                })
                
            }else if vdEnum == .Bottom {
                
                self.snp.makeConstraints( { (make) -> Void in
                    c = make.bottom.equalTo(relationView.snp.bottom).offset(-o)
                })
                
            }else if vdEnum == .Right {
                
                self.snp.makeConstraints( { (make) -> Void in
                    c = make.bottom.equalTo(relationView.snp.trailing).offset(-o)
                })
            }
            
        }else if sdEnum == .Right {
            
            if vdEnum == .Top {
                
                self.snp.makeConstraints({ (make) -> Void in
                    c = make.trailing.equalTo(relationView.snp.top).offset(o)
                })
                
            }else if vdEnum == .Left {
                
                self.snp.makeConstraints({ (make) -> Void in
                    c = make.trailing.equalTo(relationView.snp.leading).offset(o)
                })
                
            }else if vdEnum == .Bottom {
                
                self.snp.makeConstraints({ (make) -> Void in
                    c = make.trailing.equalTo(relationView.snp.bottom).offset(-o)
                })
                
            }else if vdEnum == .Right {
                
                self.snp.makeConstraints({ (make) -> Void in
                    c = make.trailing.equalTo(relationView.snp.trailing).offset(-o)
                })
            }
        }
        
        return c
    }
    

    /** 方位 */
    enum Direction: Int{
        
        case Top,Left,Bottom,Right
    }
}



