//
//  TypeChooseVC.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


enum PhotoType: Int {
    
    case Local
    case Host
}



class PhotoTypeChooseVC: UIViewController {
    
    var langType: LangType!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var localBtn: UIButton!
    
    @IBOutlet weak var hostBtn: UIButton!
}

extension PhotoTypeChooseVC{
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if langType == LangType.Chinese {return}
        
        titleLabel.text = "Select Type"
        localBtn.setTitle("Local Album", forState: UIControlState.Normal)
        localBtn.titleLabel?.font = UIFont.systemFontOfSize(20)
        hostBtn.setTitle("Host Album", forState: UIControlState.Normal)
        hostBtn.titleLabel?.font = UIFont.systemFontOfSize(20)
    }
    
    @IBAction func btnClick(sender: UIButton) {
        
        let showTypeChooseVC = ShowTypeChooseTVC(style: UITableViewStyle.Plain)
        showTypeChooseVC.langType = langType
        showTypeChooseVC.photoType = PhotoType(rawValue: sender.tag)
        self.navigationController?.pushViewController(showTypeChooseVC, animated: true)
    }
    
    
    
    
}