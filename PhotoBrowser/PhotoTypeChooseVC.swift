//
//  TypeChooseVC.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


enum PhotoType: Int {
    
    case local
    case host
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
        
        if langType == LangType.chinese {return}
        
        titleLabel.text = "Select Type"
        localBtn.setTitle("Local Album", for: UIControlState())
        localBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        hostBtn.setTitle("Host Album", for: UIControlState())
        hostBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        let showTypeChooseVC = ShowTypeChooseTVC(style: UITableViewStyle.plain)
        showTypeChooseVC.langType = langType
        showTypeChooseVC.photoType = PhotoType(rawValue: sender.tag)
        self.navigationController?.pushViewController(showTypeChooseVC, animated: true)
    }
    
    
    
    
}
