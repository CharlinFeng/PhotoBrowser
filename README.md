![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/title.jpg)
<br/><br/>
###[中文文档](https://github.com/nsdictionary/PhotoBrowser/blob/master/README_CH.md)
###[个人微博](http://weibo.com/charlin2015/) 、[时点软件](http://ios-android.cn/)
<br/><br/>
#### Begin
<br/><br/><br/>
Photo Browser Terminator
===============
<br/>
.Swift 1.2<br/><br/>
.Xcode 6.3

<br/>
####This framework is a bit large and you’d better get ready to download the package while browsing.
<br/>
### （一）Summary
1.We already have a OC version of this framework. This time we bring our latest consequent by Swift .https://github.com/nsdictionary/CorePhotoBrowserVC。<br/>
2.Support Swift，Localization and network, landscape and portrait, all of apple mobile devices.<br/>
3.based on frameworks as below: CFSnapKit、Haneke、NVActivityIndicatorView<br/>
4. please read this readme before get started.<br/>
5.This framework was finished on my trip to Zoige grassland. Enjoy the  delightful views in this framework materials<br/>
6.pod unavailable。<br/>



<br/><br/><br/>
How To Get Started
===============

<br/><br/>
###  1.Add
drag folder PhotoBrowser、Frameworks into your project.

<br/><br/>
###  2.introduction to local and network photo album

<br/>
#### 2.1 local photo album

/** local photo album */
func showLocal(index: Int){
    
    
    let pbVC = PhotoBrowser()
    
    /**  set album demonstration style  */
    pbVC.showType = showType
    
    /**  set album style  */
    pbVC.photoType = PhotoBrowser.PhotoType.Local
    
    //forbid showing all info
    pbVC.hideMsgForZoomAndDismissWithSingleTap = true
    
    var models: [PhotoBrowser.PhotoModel] = []
    
    let title = langType == LangType.Chinese ? titleLocalCH : titleEN
    let desc = langType == LangType.Chinese ? descLocalCH : descLocalEN
    
    //model data array
    for (var i=0; i<9; i++){
        
        let model = PhotoBrowser.PhotoModel(localImg:UIImage(named: "\(i+1).jpg")! , titleStr: title, descStr:desc[i], sourceView: displayView.subviews[i] as! UIView)
        
        models.append(model)
    }
    /**  set models   */
    pbVC.photoModels = models
    
    pbVC.show(inVC: self,index: index)
}

<br/>
#### 2.2 network photo album

/** 网络相册相册 */
func showHost(index: Int){
    
    
    let pbVC = PhotoBrowser()
    
    /**  set album demonstration style  */
    pbVC.showType = showType
    
    /**  set album style   */
    pbVC.photoType = PhotoBrowser.PhotoType.Host
    
    //forbid showing all info
    pbVC.hideMsgForZoomAndDismissWithSingleTap = true
    
    var models: [PhotoBrowser.PhotoModel] = []
    
    let titles = langType == LangType.Chinese ? titleHostCH : titleHostEN
    let descs = langType == LangType.Chinese ? descHostCH : descHostEN
    
    //model data array
    for (var i=0; i<9; i++){
        
        let model = PhotoBrowser.PhotoModel(hostHDImgURL: hostHDImageUrls[i], hostThumbnailImg: (displayView.subviews[i] as! UIImageView).image, titleStr: titles[i], descStr: descs[i], sourceView: displayView.subviews[i] as! UIView)
        models.append(model)
    }
    
    /**  set models  */
    pbVC.photoModels = models
    
    pbVC.show(inVC: self,index: index)
}


<br/><br/>
#### summary of differences between local and network album:：<br/>
1.photo browser  attribute show type: local album with enum value Local counterpart to Network album with enum value Host<br/>
2.photo browser’s photo model : PhotoBrowser.PhotoModel with two initialize method as below:<br/>
Local photo album:  PhotoBrowser.PhotoModel(localImg:...，<br/>
Network photo album:  PhotoBrowser.PhotoModel(hostHDImgURL:...这个方法。




<br/><br/><br/>
### 3.USAGE：

<br/>
#### (1) basic display
photo browser initial with the current  view controller rather than navigationVC or tabBarVC<br/>
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/1.gif)<br/>

<br/>



#### (2) no NavBar and TabBar
add an attribute in info.plist with: View controller-based status bar appearance and set the value<br/>
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/2.gif)<br/>

<br/>
#### (3) NavBar， no TabBar
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/3.gif)<br/>

<br/>
#### (4) tabBar, no NavBar
attention: the photo browser is based on a vc. you’d better not use vc.edgesForExtendedLayout . in case of the photo browser  with a non-full-screen state.<br/>
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/4.gif)<br/>

<br/>
#### (5) NavBar, TabBar
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/5.gif)<br/>

<br/>
#### (6) push pattern
##### pbVC.showType = PhotoBrowser.ShowType.Push <br/>

![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/6.gif)<br/>

<br/>
#### (7) Modal pattern
#####pbVC.showType = PhotoBrowser.ShowType.Modal <br/>

![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/7.gif)<br/>

<br/>
#### (8) Zoom pattern: a NetEase style
##### pbVC.showType = PhotoBrowser.ShowType.ZoomAndDismissWithCancelBtnClick <br/>
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/8.gif)<br/>

<br/>
#### (9)Zoom pattern: a weChat Style
#####pbVC.showType = PhotoBrowser.ShowType.ZoomAndDismissWithSingleTap <br/>

![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/9.gif)<br/>
<br/>

#### (10) lanscape pattern
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/10.gif)<br/>

<br/>
#### (11) photo backup
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/11.gif)<br/>

<br/>
#### (12) browser information by scrolling
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/12.gif)<br/>


<br/>
#### (13) one-click pattern: with tile and more details info
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/17.gif)<br/>

<br/>
#### (14) one-click pattern: without any info
attention: the effect is active under ZoomAndDismissWithSingleTap sence
pbVC.hideMsgForZoomAndDismissWithSingleTap = true<br/>
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/18.gif)<br/>

<br/>
#### (15) using black pic as thumbnail by default
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/13.gif)<br/>

<br/>
#### (16) thumbnail load , original pic is loading state:
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/14.gif)<br/>

<br/>
#### (17) thumbnail load , original pic load state:
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/15.gif)<br/>

<br/>
#### (18) thumbnail load, original pic download and animation style
![image](https://github.com/CharlinFeng/Resource/blob/master/PhotoBrowser/Show/16.gif)<br/>





<br/><br/><br/>
License
===============
My Framework based on MIT License



