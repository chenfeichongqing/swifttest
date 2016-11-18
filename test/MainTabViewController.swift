//
//  MainTabViewController.swift
//  xQQ
//
//  Created by 方武显 on 15/3/9.
//  Copyright (c) 2015年 小五哥Swift教程. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class MainTabViewController:UITabBarController,SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UIActionSheetDelegate{
    
    var colltionView : UICollectionView?
    var anquanhuodong: Anquanhuodong!
     var imagePicker   : UIImagePickerController!
    let dataArr1 = [
        ["name":"下发指令","pic":"1"],
        ["name":"人车站","pic":"2"],
        ["name":"统计培训","pic":"3"],
        ["name":"预警考核","pic":"4"],
        ]
    let dataArr2 = [
        
        ["name":"隐患排查","pic":"5"],
        ["name":"异常排序","pic":"6"],
        ["name":"燃油补贴","pic":"7"],
        ["name":"事故处理","pic":"8"],
        ["name":"事故报告","pic":"9"],
        ]
    
   /* let dataArr1 = [
        ["name":"安全检查","pic":"1"],
        ["name":"人车信息","pic":"2"],
        ]
    let dataArr2 = [
        
        ["name":"风险指数","pic":"5"],
        ["name":"隐患排查","pic":"6"],
        ["name":"车辆异常","pic":"7"],
        ["name":"事故统计","pic":"8"],
        ]*/
    // 情景二：采用网络图片实现
    let imagesURLStrings = [
        "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
        "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
        "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
        "http://upload.cankaoxiaoxi.com/2016/1101/1477971576409.jpg"
    ];
    
    // 情景三：图片配文字
    let titles = ["重庆永川发生瓦斯爆炸事故",
                  "北京时间10点中国国足90分总不射",
                  "越南仔南海向中国挑衅，被全军覆没",
                  "中国又开始援建非洲黑人朋友了"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor=UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneSlide))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: nil)
        let demoContainerView = UIScrollView(frame: UIScreen.main.bounds)
        let cycleScrollView = SDCycleScrollView.init(frame: CGRect(x:0, y:64, width:KSCREEN.width, height:KSCREEN.width/2), delegate: self, placeholderImage:UIImage(named:"placeholder")!)
        //  cycleScrollView?.currentPageDotImage = UIImage (named:"pageControlCurrentDot")
        cycleScrollView?.pageControlAliment = SDCycleScrollViewPageContolAlimentRight
        cycleScrollView?.titlesGroup = titles;
        cycleScrollView?.currentPageDotColor = UIColor.white// 自定义分页控件小圆标颜色
        // cycleScrollView?.pageDotImage = UIImage (named:"pageControlDot")
        // cycleScrollView?.imageURLStringsGroup = imagesURLStrings
        
        cycleScrollView?.imageURLStringsGroup = imagesURLStrings
        demoContainerView.addSubview(cycleScrollView!)
        let layout = UICollectionViewFlowLayout()
        let rows1 = Int(dataArr1.count/4)+1
        let rows2 = Int(dataArr2.count/4)+1
        var cellheight:Int
        var cellwidth:Int
    /*
        //设置每一个cell的宽高
        if(isIPhone5()){
            cellwidth=80
            cellheight=100
        }
        else if (isIPhone6()) {
            cellwidth=85
            cellheight=110
            
        }
        else if(isIPhone6Plus()){
            cellwidth=90
            cellheight=130
        }
        else{
            cellwidth=80
            cellheight=100
         
        }
 */
        cellwidth = Int( KSCREEN.width/4)
        cellheight = Int(KSCREEN.width/4 * 1.2)
        layout.itemSize = CGSize(width:cellwidth, height:cellheight)
        //滑动方向 默认方向是垂直
        layout.scrollDirection = .vertical
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 0
        //每行之间最小的间距
        layout.minimumLineSpacing = 0
        colltionView = UICollectionView(frame: CGRect(x:0, y:KSCREEN.width/2+64, width:KSCREEN.width, height:CGFloat((rows1+rows2)*cellheight+80)), collectionViewLayout: layout)
        colltionView!.register(UINib(nibName: "testCell", bundle: nil), forCellWithReuseIdentifier: "mycell")
        // 注册一个headView
        colltionView!.register(CollectionReusableViewHeader.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        // 注册一个footView
        //  colltionViewtop!.register(CollectionReusableViewFooter.self, forSupplementaryViewOfKind:UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier)
        colltionView?.delegate = self;
        colltionView?.dataSource = self;
        colltionView?.backgroundColor = UIColor.white
        colltionView?.isScrollEnabled=false
        demoContainerView.addSubview(colltionView!)
        let scroviewheight=(cycleScrollView?.bounds.size.height)!+(colltionView?.bounds.size.height)!+50
        demoContainerView.contentSize=CGSize(width:self.view.frame.size.width, height:scroviewheight);
        
        let toplogo =  UIImageView.init(frame: CGRect(x:KSCREEN.width/3, y:0, width:KSCREEN.width/3, height:55))
        toplogo.image = UIImage(named:"dibulogo")
        demoContainerView.addSubview(toplogo)
        self.view.addSubview(demoContainerView)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //返回多少个cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if  section == 0 {
            /// 执行第一个 table 的代码
            return dataArr1.count
        } else  {
            /// 执行第一个 table 的代码
            return dataArr2.count
        }
    }
    // 返回自定义HeadView或者FootView，我这里以headview为例
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        var reusableview:UICollectionReusableView!
        
        if kind == UICollectionElementKindSectionHeader
        {
            reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! CollectionReusableViewHeader
            reusableview.backgroundColor = UIColor.init(red: 214/255, green: 214/255, blue: 214/255, alpha: 1)
            if indexPath.section==0 {
                (reusableview as! CollectionReusableViewHeader).label.text = String(format: "功能列表", arguments: [indexPath.section])
            }
            else{
                (reusableview as! CollectionReusableViewHeader).label.text = String(format: "统计信息", arguments: [indexPath.section])
            }
            
        }
        return reusableview
    }
    //返回自定义的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath as IndexPath) as! testCell
        if  indexPath.section==0 {
            /// 执行第一个 table 的代码
            cell.gongneng.setImage(UIImage(named: dataArr1[indexPath.item]["pic"]!), for: .normal)
            cell.gongneng.setTitle(dataArr1[indexPath.item]["name"], for: .normal)
        } else  if(indexPath.section==1){
            /// 执行第一个 table 的代码
            cell.gongneng.setImage(UIImage(named: dataArr2[indexPath.item]["pic"]!), for: .normal)
            cell.gongneng.setTitle(dataArr2[indexPath.item]["name"], for: .normal)
        }
        return cell
    }
    // 返回HeadView的宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
    {
        return CGSize(width: width, height: heightHeader)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell =  collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = String(format: ("你点击了第 %d-%d 个cell"), arguments: [indexPath.section + 1, indexPath.row + 1])
        let alert = UIAlertView(title: nil, message: text, delegate: nil, cancelButtonTitle: "知道了")
        alert.show()
        
        if indexPath.section==0 {
            if (indexPath.row==0) {
                let webview = MyfirstwebViewController()
                let webviewNav = UINavigationController.init(rootViewController: webview)
                //从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
                self.present(webviewNav, animated: true, completion: nil)
            }
            else if(indexPath.row==1){
                
                let chat = mychatview()
                //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
                chat.conversationType = RCConversationType.ConversationType_PRIVATE
                //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
                chat.targetId = "test"
                //设置聊天会话界面要显示的标题
                chat.title = "test"
                //显示聊天会话界面
                // self.present(chat, animated: true, completion: nil)
                chat.hidesBottomBarWhenPushed=true
                self.navigationController?.pushViewController(chat, animated: true)
                
            }
            else if (indexPath.row==2){
                
                let chatList = mychatlistview()
                chatList.hidesBottomBarWhenPushed=true
                chatList.title = "会话列表"
                self.navigationController?.pushViewController(chatList, animated: true)
            }
            else if (indexPath.row==3){
                
                let webview = LocalhtmlViewController()
                let webviewNav = UINavigationController.init(rootViewController: webview)
                
                //从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
                self.present(webviewNav, animated: true, completion: nil)        }
        }
        else if(indexPath.section==1){
            
            
            if (indexPath.row==0){
                
                selectImageAction()
                
                /*
                
                let buffer = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
                
                anquanhuodong =  NSEntityDescription.insertNewObject(forEntityName: "Anquanhuodong", into: buffer!) as! Anquanhuodong
                anquanhuodong.id=32
                anquanhuodong.title = "chenfei"
                anquanhuodong.url = "123456"
                if let image = UIImage(named: dataArr1[2]["pic"]!) {
                    let salFac = image.size.width > 600 ? 600 / image.size.width : 1
                    anquanhuodong.image = UIImageJPEGRepresentation(image, salFac) as NSData?
                }
                
                do {
                    try buffer?.save()
                } catch {
                    print(error)
                    return
                }*/
            }
            else if (indexPath.row==1){
                
                let buffer = (UIApplication.shared.delegate as? AppDelegate)?.managedObjectContext
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Anquanhuodong")
                //        let predicate = NSPredicate(format:"id=1")  //设置查询条件按照id查找不设置查询条件，则默认全部查找
                //        fetchRequest.predicate=predicate
                fetchRequest.fetchLimit = 10 //限定查询结果的数量
                fetchRequest.fetchOffset = 0 //查询的偏移量
                fetchRequest.returnsDistinctResults=false
                do {
                    let searchResults = try buffer?.fetch(fetchRequest)
                    print("numbers of \(searchResults?.count)")
                    
                    for p in (searchResults as! [NSManagedObject]){
                        print("name:  \(p.value(forKey: "title")!) age: \(p.value(forKey: "image")!)")
                    }
                } catch  {
                    print(error)
                }
                
            }
            else if (indexPath.row==2){
                
                let uitableview = myTableViewController()
                let view = UINavigationController.init(rootViewController: uitableview)
                
                //从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
                self.present(view, animated: true, completion: nil)        }
            
            
            
        }
        
        
    }
    //点击侧滑按钮动作
    func doneSlide(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.drawer.toggle(MMDrawerSide.left, animated: true, completion: nil)
    }
    
    func selectImageAction(){
    
        let actionSheetController: UIAlertController = UIAlertController(title: "请选择", message:nil, preferredStyle: .actionSheet)
        
        //取消按钮
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        
        actionSheetController.addAction(cancelAction)
        
        //拍照
        let takePictureAction: UIAlertAction = UIAlertAction(title: "拍照", style: .default)
        { action -> Void in
            
            
            self .initWithImagePickView(type: "拍照")
            
        }
        
        actionSheetController.addAction(takePictureAction)
        
        //相册选择
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "相册", style: .default)
        { action -> Void in
            
            self .initWithImagePickView(type: "相册")
            
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        //摄像
        let moviePictureAction: UIAlertAction = UIAlertAction(title: "摄像", style: .default)
        { action -> Void in
            
            self .initWithImagePickView(type: "摄像")
            
        }
        
        actionSheetController.addAction(moviePictureAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    
    }
    func initWithImagePickView(type:NSString){
        

        }
        
    }
