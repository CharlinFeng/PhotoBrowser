//
//  ViewController.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

enum LangType: Int{
    
    case english
    case chinese
}





class LangVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


extension LangVC{
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        let photoTypeChooseVC = PhotoTypeChooseVC(nibName: "PhotoTypeChooseVC", bundle: nil)
        photoTypeChooseVC.langType = LangType(rawValue: sender.tag)
        self.navigationController?.pushViewController(photoTypeChooseVC, animated: true)
    }
    
}
