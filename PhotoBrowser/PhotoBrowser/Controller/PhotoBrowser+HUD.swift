//
//  PhotoBrowser+HUD.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/11.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


extension PhotoBrowser{
  
    
    /** 展示 */
    func showHUD(_ text: String,autoDismiss: Double){
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.hud.alpha = 1
        })
        
        hud.text = text
        
        self.view.addSubview(hud)
        hud.make_center(offsest: CGPoint.zero, width: 120, height: 44)
        
        if autoDismiss == -1 {return}
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(autoDismiss * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {[unowned self] () -> Void in
            
            self.dismissHUD()
        })
    }
    
    /** 消失 */
    func dismissHUD(){
        
        UIView.animate(withDuration: 0.25, animations: {[unowned self] () -> Void in
            
            self.hud.alpha = 0
            
        }, completion: { (compelte) -> Void in
            
            self.hud.text = ""
            
            self.hud.removeFromSuperview()
        }) 
    }
    
}

