//
//  MylistviewTableViewController.swift
//  test
//
//  Created by 陈小爷 on 2016/11/9.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit
import MJRefresh
import RealmSwift

class MylistviewTableViewController: UITableViewController{
    
 var tableview: UITableView!
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    let puppies = realm.objects(Listitem.self)
    var dateFormatter = DateFormatter()
    let ID = "Cell" //cell的ID，建议像这样写一个常量，不要直接使用"Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: ID)
        //下面这种写法也是可以的
        //tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: ID)
        //3.设置数据源和代理
        tableview.dataSource = self
        tableview.delegate = self;
        //4.添加到view中
        self.view.addSubview(tableview)
        
     
       /* dateFormatter.dateFormat="yyyy年MM月dd日"

        // 下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        // 现在的版本要用mj_header
        tableview.mj_header = header
        
        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        tableview.mj_footer = footer
       /* let myitme = Listitem()
        myitme.name = "Rex"
        myitme.title = "wocaoaoaa"
        myitme.datetime=NSDate()
        if let image = UIImage(named: "1") {
            let salFac = image.size.width > 600 ? 600 / image.size.width : 1
            myitme.imageview = UIImageJPEGRepresentation(image, salFac) as NSData?
        }
        
        try! realm.write {
            realm.add(myitme)
        }*/
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()*/
    }
    // 懒加载
    lazy var datas: [Int] = {
        // 创建一个存放int的数组
        var nums = [Int]()
        // 添加数据
        for i in 0...50 {
            nums.append(i)
        }
        // 返回
        return nums
    }()
    // 顶部刷新
    func headerRefresh(){
        print("下拉刷新")
        // 结束刷新
        self.tableview.mj_header.endRefreshing()
    }
    
    // 底部刷新
    var index = 0
    func footerRefresh(){
        print("上拉刷新")
        self.tableview.mj_footer.endRefreshing()
        // 2次后模拟没有更多数据
        index = index + 1
        if index > 2 {
            footer.endRefreshingWithNoMoreData()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return datas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ID, for: indexPath)
        // 配置cell
        cell.textLabel!.text = "假数据 - \(datas[indexPath.row])"
        // 返回cell
        return cell
    }
     }
   /* override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! UitableviewCellTableViewCell
        
     /*   let puppie=puppies[indexPath.row]
        cell.name.text = puppie.name
        cell.title.text = puppie.title
        
        cell.datatime.text=dateFormatter.string(from: puppie.datetime as Date)
        // Configure the cell...
*/
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150;
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}*/
