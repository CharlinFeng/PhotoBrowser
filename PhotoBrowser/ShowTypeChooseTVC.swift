//
//  ShowTypeChooseVCTableViewController.swift
//  PhotoBroswer
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(rid) as? UITableViewCell ?? UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: rid)
        
        cell.textLabel?.text = dataList[indexPath.row]
        cell.textLabel?.font = UIFont.systemFontOfSize(24)
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let displayVC = DisplayVC()
        displayVC.langType = langType
        displayVC.photoType = photoType
        
        switch indexPath.row {
        
            case 0:displayVC.showType = PhotoBroswer.ShowType.Push
            case 1:displayVC.showType = PhotoBroswer.ShowType.Modal
            case 2:displayVC.showType = PhotoBroswer.ShowType.ZoomAndDismissWithCancelBtnClick
            case 3:displayVC.showType = PhotoBroswer.ShowType.ZoomAndDismissWithSingleTap
            default: break
        }
        
        self.navigationController?.pushViewController(displayVC, animated: true)
    }
}
