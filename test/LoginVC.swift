//
//  LoginVC.swift
//  test
//
//  Created by 陈小爷 on 2016/10/26.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON


class LoginVC: UIViewController, UITextFieldDelegate,RCIMUserInfoDataSource {
    var txtUser: UITextField! //用户名输入框
    var txtPwd: UITextField! //密码输入款
    var formView: UIView! //登陆框视图
    var horizontalLine: UIView! //分隔线
    var confirmButton:UIButton! //登录按钮
    var titleLabel: UILabel! //标题标签
    var topConstraint: Constraint? //登录框距顶部距离约束
    var userinfo:UserInfo?
    var forgetpwd:UIButton?
    var register:UIButton?
    let width = UIScreen.main.bounds.size.width//获取屏幕宽
    let height = UIScreen.main.bounds.size.height//获取屏幕高度
    let kScreenColoc = UIColor(red: 111/255, green:218/255 , blue:242/255 , alpha: 1)
    var window: UIWindow?
    var drawer:MMDrawerController!
    var introView: SwiftIntroView!
    var userToken:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RCIM.shared().userInfoDataSource = self
        
   /*     if(!UserDefaults.standard.bool(forKey: "firstLaunch"))
        {
            
            introView = SwiftIntroView(frame: self.view.frame)
            introView.delegate = self
            introView.backgroundColor = UIColor.white
            self.view.addSubview(introView)
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            UserDefaults.standard.synchronize()
        }
        else
        {*/
            createdMainView()
             UserDefaults.standard.set(false, forKey: "firstLaunch")
   //     }
        
        
    }
    
    func getUserInfo(withUserId userId: String!, completion: ((RCUserInfo?) -> Void)!) {
        let  userinfo = RCUserInfo()
        userinfo.userId=userId
        userinfo.name=userId
        userinfo.portraitUri="http://img3.duitang.com/uploads/item/201508/30/20150830083023_N3rTL.png"
        return  completion(userinfo)
    }
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: -(self.height/8))
            self.view.layoutIfNeeded()
        })
    }
    //输入框返回时操作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        switch tag {
        case 100:
            self.txtPwd.becomeFirstResponder()
        case 101:
            loginConfrim()
        default:
            print(textField.text)
        }
        return true
    }
    
    
    //登录按钮点击
    func loginConfrim(){
        //收起键盘
        self.view.endEditing(true)
        //视图约束恢复初始设置
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        })
        
        let username=self.txtUser.text
        let password = self.txtPwd.text
        
        if (username?.isEmpty)! {
            //  Toast.instance.showToast(content: "用户名为空，请填写用户名")
            self.view.makeToast("用户名为空，请填写用户名")
            return
        }
        if (password?.isEmpty)! {
            self.view.makeToast("密码为空，请填写用户名")
            return
        }
        let parameters = ["name": ""+username!,"password":""+password!]
        HUD.flash(.labeledProgress(title: "", subtitle: "登陆中..."))
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.present(appDelegate.drawer, animated: true, completion: nil)
      /*  Alamofire.request("http://api.cqxyyxxkj.cn/user/login", method:.post,parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    if let json = response.result.value {
                        
                        let jsonobject = JSON(json)
                        self.userinfo=UserInfo.init(fromJson:jsonobject)
                        UserDefaults.standard.set(self.userinfo?.content?.uId, forKey: "userid")
                        UserDefaults.standard.set(self.userinfo?.content?.uName, forKey: "username")
                        UserDefaults.standard.set(password!+"", forKey: "userpassword")
                        UserDefaults.standard.set(self.userinfo?.content?.uPhone, forKey: "userphone")
                        UserDefaults.standard.set(self.userinfo?.content?.uRealname, forKey: "urealname")
                        UserDefaults.standard.set(self.userinfo?.content?.uSex, forKey: "usersex")
                        UserDefaults.standard.set(self.userinfo?.content?.uUnit, forKey: "uunit")
                        UserDefaults.standard.synchronize()
                        
                      //  self.requestToken(userID: (self.userinfo?.content?.uName)!)
                                                HUD.hide()
                    }

                case .failure(let error):
                    HUD.flash(.error, delay: 1.0)
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    self.present(appDelegate.drawer, animated: true, completion: nil)

                    print(error)
                }
                    
        }*/
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createdMainView () {
        self.view.backgroundColor=UIColor.init(patternImage: UIImage(named:"bg.jpg")!)
        //登录框高度
        let formViewHeight = height/6
        //登录框背景
        self.formView = UIView()
        self.formView.layer.borderWidth = 0.5
        self.formView.layer.borderColor = UIColor.lightGray.cgColor
        self.formView.backgroundColor = UIColor.white
        self.formView.layer.cornerRadius = 5
        self.view.addSubview(self.formView)
        //最常规的设置模式
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            //存储top属性
            self.topConstraint = make.centerY.equalTo(self.view).constraint
            make.height.equalTo(formViewHeight)
        }
        
        //分隔线
        self.horizontalLine =  UIView()
        self.horizontalLine.backgroundColor = UIColor.lightGray
        self.formView.addSubview(self.horizontalLine)
        self.horizontalLine.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalTo(self.formView)
        }
        
        //密码图
        let imgLock1 =  UIImageView(frame:CGRect(x:formViewHeight/8, y:formViewHeight/8, width:formViewHeight/4, height:formViewHeight/4))
        imgLock1.image = UIImage(named:"icon_login_user_name")
        //imgLock1.image = #imageLiteral(resourceName: "icon_login_user_name")
        
        
        //密码图
        let imgLock2 =  UIImageView(frame:CGRect(x:formViewHeight/8, y:formViewHeight/8, width:formViewHeight/4, height:formViewHeight/4))
        imgLock2.image = UIImage(named:"icon_login_password")
        // imgLock2.image = #imageLiteral(resourceName: "icon_login_password")
        //用户名输入框
        self.txtUser = UITextField()
        self.txtUser.delegate = self
        self.txtUser.placeholder = "用户名"
        self.txtUser.tag = 100
        self.txtUser.leftView = UIView(frame:CGRect(x:0, y:0, width:formViewHeight/2-1, height:formViewHeight/2-1))
        self.txtUser.leftViewMode = UITextFieldViewMode.always
        self.txtUser.returnKeyType = UIReturnKeyType.next
        
        //用户名输入框左侧图标
        self.txtUser.leftView!.addSubview(imgLock1)
        self.formView.addSubview(self.txtUser)
        
        //布局
        self.txtUser.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(formViewHeight-1)
            make.centerY.equalTo(0).offset(formViewHeight/4)
        }
        
        //密码输入框
        self.txtPwd = UITextField()
        self.txtPwd.delegate = self
        self.txtPwd.placeholder = "密码"
        self.txtPwd.tag = 101
        self.txtPwd.leftView = UIView(frame:CGRect(x:0, y:0, width:formViewHeight/2-1, height:formViewHeight/2-1))
        self.txtPwd.leftViewMode = UITextFieldViewMode.always
        self.txtPwd.returnKeyType = UIReturnKeyType.next
        
        //密码输入框左侧图标
        self.txtPwd.leftView!.addSubview(imgLock2)
        self.formView.addSubview(self.txtPwd)
        
        //布局
        self.txtPwd.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(formViewHeight-1)
            make.centerY.equalTo(0).offset(formViewHeight/4*3)
        }
        
        //登录按钮
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("登录", for: UIControlState.normal)
        self.confirmButton.setTitleColor(UIColor.white,
                                         for: UIControlState.normal)
        self.confirmButton?.setTitleColor(UIColor.gray, for: UIControlState.selected)
        self.confirmButton.layer.cornerRadius = 5
        //self.confirmButton.backgroundColor=UIColor.blue
        self.confirmButton.backgroundColor = kScreenColoc
        self.confirmButton.addTarget(self, action: #selector(loginConfrim),
                                     for: .touchUpInside)
        self.view.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.equalTo(self.formView.snp.bottom).offset(20)
            make.right.equalTo(-15)
            make.height.equalTo(formViewHeight/2-1)
        }
        
        //标题label
        self.titleLabel = UILabel()
        self.titleLabel.text = "安全管理系统"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.systemFont(ofSize: 28)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(height/15)
          //  make.height.equalTo(height/20)
            make.centerX.equalTo(self.view)
        }
        let touxiang=UIImageView()
        
        touxiang.image = UIImage(named: "logo")
       // touxiang.layer.cornerRadius = height/20
        touxiang.layer.masksToBounds = true
       // touxiang.layer.borderWidth = 1
       // touxiang.layer.borderColor = UIColor.orange.cgColor
        self.view.addSubview(touxiang)
        
        
        touxiang.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleLabel).offset(height/15+20)
            make.height.equalTo(height/5)
            make.width.equalTo(height/5)
            make.centerX.equalTo(self.view)
            
        }
        if let name = UserDefaults.standard.string(forKey: "username"){
            self.txtUser.text=name
        }
        if let password = UserDefaults.standard.string(forKey: "userpassword"){
            self.txtPwd.text=password
        }
        
        self.forgetpwd=UIButton.init(type:UIButtonType.system)
        self.forgetpwd?.setTitle("忘记密码？", for: UIControlState.normal)
        self.forgetpwd?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //self.forgetpwd?.setTitleColor(UIColor.blue,
        //                              for: UIControlState.normal)     //
        self.forgetpwd?.setTitleColor(UIColor.gray, for: UIControlState.selected)
        self.view.addSubview(self.forgetpwd!)
        self.forgetpwd?.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(-30)
            make.left.equalTo(20)
        }
        self.register=UIButton.init(type:UIButtonType.system)
        self.register?.setTitle("注册", for: UIControlState.normal)
        self.register?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        //self.forgetpwd?.setTitleColor(UIColor.blue,
        //                              for: UIControlState.normal)     //
        self.register?.setTitleColor(UIColor.gray, for: UIControlState.selected)
        self.view.addSubview(self.register!)
        self.register?.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(-30)
            make.right.equalTo(-20)
        }
    }

    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    func requestToken(userID:String) -> Void {
        let dicUser = ["userId":userID,"name":userID,"portraitUrl":"http://img3.duitang.com/uploads/item/201508/30/20150830083023_N3rTL.png"] //请求token的用户信息
        let str = "https://api.cn.rong.io/user/getToken.json" //网址接口
        let appKey = "pvxdm17jxmanr"
        let appSecret = "kX7tQl1k563"
        
        let nonce = "\(arc4random())"   //生成随机数
        let timestamp = "\(NSInteger( NSDate.timeIntervalSinceReferenceDate))"//时间戳
        let sha1str=appSecret+nonce+timestamp
        
        let sha1Value = sha1str.sha1 //数据签名
        
        let headers: HTTPHeaders = [             //照着文档要求写的Http 请求的 4个head  （回头再学习下http）
            "App-key":appKey
            ,"Nonce":nonce
            ,"Timestamp":timestamp
            ,"Signature":sha1Value!
        ]
        //此处我用到了第三方的网络请求库，用系统的自带的也可以叫NSUrlSession，用过一次感觉相对这个比较复杂一点点点点
        Alamofire.request(str ,method: .post, parameters: dicUser,  headers: headers).responseJSON { (response) in
            
            //如果请求成功，这个response里面的result下的value就是这玩意
            //{"code":200,"userId":"sample","token":"LalOUsa3cyWOrfwlMfOp1CSuIH8lXjFx9vVolp0sVjdawJkv1sjb+0LZAig7gpMO3SkK0wWywvI8gfIkQMYp2A=="}
            // 怎么从里面拿到token大家应该都会吧：）
            
            if let dic = response.result.value  as? NSDictionary {
                let code = dic.value(forKey: "code") as! NSNumber
                if code.stringValue == "200" {
                    // 以下是我自己对服务器的操作，把拿到的token上传到我数据服务器里去
                    self.userToken = (dic.value(forKey: "token") as? String)!
                    print(self.userToken)
                    self.userinfo?.content?.userToken = self.userToken
                    RCIM.shared().connect(withToken:self.userToken,
                                                       success: { (userId) -> Void in
                                                        print("登陆成功。当前登录的用户ID：\(userId)")
                                                        
                                                        let currentuser = RCUserInfo(userId:userId,name:userId,portrait:"")
                                                        RCIM.shared().currentUserInfo=currentuser
                                                     //   HUD.flash(.success)
                                                    
                                                        
                                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                            self.present(appDelegate.drawer, animated: true, completion: nil)
                                                            HUD.hide()
                                                            
                                                        
                                                        
                        }, error: { (status) -> Void in
                            print("登陆的错误码为:\(status.rawValue)")
                        }, tokenIncorrect: {
                            //token过期或者不正确。
                            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                            print("token错误")
                    })
                    
                    
                }
                
                
            }
        }
    }
    
   // ###写下如下方法(调用时传入一个useId的字符串)
    func requestToken1(userID:String) -> Void {
        let dicUser = ["userId":userID,
                       "name":userID,
                       "portraitUrl":"http://img3.duitang.com/uploads/item/201508/30/20150830083023_N3rTL.png"
        ] //请求token的用户信息
        let urlStr = "https://api.cn.ronghub.com/user/getToken.json" //网址接口
        let appKey = "pvxdm17jxmanr"
        let appSecret = "kX7tQl1k563"
        let nonce = "\(arc4random())"   //生成随机数
        let timestamp = "\(NSDate().timeIntervalSince1970)"//时间戳
        var sha1Value = appSecret + nonce + timestamp
        sha1Value = sha1Value.sha1//数据签名,sha1是一个加密的方法
        let headers = [ //照着文档要求写的Http 请求的 4个head
            "App-key":appKey
            ,"Nonce":nonce
            ,"Timestamp":timestamp
            ,"Signature":sha1Value
        ]
        Alamofire.request(urlStr, method: .post, parameters: dicUser , encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            print(response)
            if let dic = response.result.value  as? NSDictionary{
                let code = dic.value(forKey: "code") as! NSNumber
                if code.stringValue == "200" {
                    print(dic.value(forKey: "token"))
                }
            }
        }
    }
}
