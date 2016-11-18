//
//  myTableViewController.swift
//  test
//
//  Created by 陈小爷 on 2016/11/9.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {
  
    
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
    let titles = ["重庆永川发生瓦斯爆炸事故",
                  "北京时间10点中国国足90分总不射",
                  "越南仔南海向中国挑衅，被全军覆没",
                  "中国又开始援建非洲黑人朋友了"
    ]
    let cellId = "hehe"
     var baby = ["数据0","数据1","数据2","数据3","数据4","数据5","数据6","数据7","数据8","数据9","数据10"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        
        tableView?.register(UINib(nibName:"mytabcell",bundle:nil), forCellReuseIdentifier: cellId)
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mycell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.dataSource=self
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func didReceiveMemoryWarning() {
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
        return titles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as! mytabcell
 
        // Configure the cell...
         cell.title.text = "dfdfdfdf"
        
      /*  let cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "mytab")
        cell.textLabel?.text = baby[indexPath.row];
        cell.imageView?.frame = CGRect(x:40,y:50,width:44,height:44);
        cell.detailTextLabel?.text = baby[indexPath.row]+"wo dfdfjsdif ";*/
        
        return cell;
    }
    func setNavBar() {
        
        let leftBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self,
                                         action: nil)
        self.navigationItem.leftBarButtonItem = leftBarBtn
         let btnForward = UIBarButtonItem(title: "前进", style: UIBarButtonItemStyle.plain, target: self, action: nil)
         self.navigationItem.rightBarButtonItem = btnForward
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
    
}
