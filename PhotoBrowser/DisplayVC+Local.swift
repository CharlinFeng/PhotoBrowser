//
//  Display+Local.swift
//  PhotoBroswer
//
//  Created by 冯成林 on 15/8/14.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


extension DisplayVC {
    
    var titleLocalCH: String {return "哆啦A梦：伴我同行"}
    var titleEN: String {return "Doraemon: walk with me"}
    

    
    var descLocalCH: [String] {
        return [
            "《哆啦A梦：伴我同行》是一部纪念《哆啦A梦》之父藤子·F·不二雄诞辰80周年的3D动画电影,该片讲述了哆啦A梦圆满完成了他的使命，启程返回22世纪，大雄该如何以一己之力实现他那来之不易的幸福未来。该片于2014年8月8日在日本上映，2015年5月28日在中国内地上映。",
            "为了什么都做不来的野比大雄，22 世纪的玄孙野比世修送了猫型机器人──哆啦A梦来现代。",
            "笨笨的野比大雄原本自己开了间公司，但很不幸的倒闭，之后剩下了一屁股债务，子孙们吃了莫大的苦。于是，野比世修才打算送哆啦A梦到现代",
            "哆啦A梦于是开始勉勉强强的协助野比大雄的日常生活。",
            "虽然刚开始不太习惯，但两个人的关系也日渐变的紧密。",
            "得知野比大雄的梦想是打算与梦中情人的同班同学源静香结婚以后，哆啦A梦就想尽办法要帮助野比大雄获得静香的芳心。",
            "正当源静香总算答应了野比大雄的求婚的时候，任务完成的哆啦A梦却被完成程式要求",
            "在48小时内回到22世纪。难道，得到了什么，自然的，也会失去些什么这个命定的预言，没办法被哆啦A梦跟野比大雄突破。",
            "面对哆啦A梦即将离开的冲击，野比大雄又该如何自处。",
        ]
    }
    
    var descLocalEN: [String] {
        return [
            "The duo la a dream: with my peers is a commemoration of Duo La a dream the father of Tengzi f. bu'erxiong birtThumbNailay 80th anniversary of 3D animated film, the film tells the story of the Duo a dream the successful completion of his mission, the journey back to the 22nd century, Nobita the how to single handedly achieve his hard won happiness in the future. The film was released in Japan in August 8, 2014 and released in May 28, 2015 in China.",
            "In order to do anything not to wild than male, the 22nd century's great great grandson Yebishixiu sent cat robot, duo la a dream to modern.",
            "Simple minded, wild than male originally opened his own company, but unfortunately the collapse, after the rest of the buttocks debt, children eat the great suffering. So, Yebishixiu only intend to send the duo A dream of modern",
            "Doraemon reluctantly began to assist the daily life of wild than male.",
            "Although just started not too accustomed to, but the relationship between the two people also gradually change the close.",
            "That wild than male's dream is to dream lover's classmate classmate Shizuka source married later, the duo la a dream will try to help wild than male Shizuka's heart.",
            "As promised when Shizuka source finally marry the wild than male tasks, Doraemon was completing the program requirements",
            "Back to twenty-second Century in 48 hours. Do what, natural and lose some what the fate of the prophecy, no way is the Duo a dream with wild than male breakthrough.",
            "In the face of Doraemon leaving the impact, how can wild than male.",
        ]
    }
    
    
    
    
    /** 本地相册 */
    func showLocal(index: Int){
        
        
        let pbVC = PhotoBroswer()
        
        /**  设置相册展示样式  */
        pbVC.showType = showType
        
        /**  设置相册类型  */
        pbVC.photoType = PhotoBroswer.PhotoType.Local
        
        //强制关闭显示一切信息
        pbVC.hideMsgForZoomAndDismissWithSingleTap = true
        
        var models: [PhotoBroswer.PhotoModel] = []
        
        let title = langType == LangType.Chinese ? titleLocalCH : titleEN
        let desc = langType == LangType.Chinese ? descLocalCH : descLocalEN
        
        //模型数据数组
        for (var i=0; i<9; i++){
        
           let model = PhotoBroswer.PhotoModel(localImg:UIImage(named: "\(i+1).jpg")! , titleStr: title, descStr:desc[i], sourceView: displayView.subviews[i] as! UIView)
            
            models.append(model)
        }

        /**  设置数据  */
        pbVC.photoModels = models
        
        pbVC.show(inVC: self,index: index)
    }

    
    
}