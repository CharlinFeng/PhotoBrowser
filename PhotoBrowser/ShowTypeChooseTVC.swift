//
//  ShowTypeChooseVCTableViewController.swift
//  PhotoBrowser
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class ShowTypeChooseTVC: UITableViewController {
    
    var langType: LangType!
    
    var photoType: PhotoType!

    let rid = "ShowTypeChooseTVCCell"

    lazy var dataList: [String] = {["Push","Modal","CancelBtnClickDissmiss","SingleTapDismiss"]}()

    
}

extension ShowTypeChooseTVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: rid) ?? UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: rid)
        
        cell.textLabel?.text = dataList[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let displayVC = DisplayVC()
        displayVC.langType = langType
        displayVC.photoType = photoType
        
        switch indexPath.row {
        
            case 0:displayVC.showType = PhotoBrowser.ShowType.push
            case 1:displayVC.showType = PhotoBrowser.ShowType.modal
            case 2:displayVC.showType = PhotoBrowser.ShowType.zoomAndDismissWithCancelBtnClick
            case 3:displayVC.showType = PhotoBrowser.ShowType.zoomAndDismissWithSingleTap
            default: break
        }
        
        self.navigationController?.pushViewController(displayVC, animated: true)
    }
}
