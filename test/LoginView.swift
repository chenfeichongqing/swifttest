//
//  LoginView.swift
//  JSByZYF
//
//  Created by zhyunfe on 16/9/22.
//  Copyright © 2016年 zhyunfe. All rights reserved.
//

import UIKit
import OpenShare

class LoginView: UIViewController,UITextFieldDelegate {
    
    
    
    
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var registeAccount: UIButton!
    
    @IBOutlet weak var Loginbtn: UIButton!
    @IBOutlet weak var cancel: UIImageView!
    @IBOutlet weak var pwdTf: UITextField!
    let width = UIScreen.main.bounds.size.width//获取屏幕宽
    let height = UIScreen.main.bounds.size.height//获取屏幕高度
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        account.delegate = self
        pwdTf.delegate = self
        setLable()
        addTap()
        eyes()
    }
    func setLable() {
        //密码图
        //登录框高度
        let formViewHeight = height/8
        let imgLock1 =  UIImageView(frame:CGRect(x:formViewHeight/8, y:formViewHeight/8, width:formViewHeight/4, height:formViewHeight/4))
        imgLock1.image = UIImage(named:"icon_login_user_name")
        //imgLock1.image = #imageLiteral(resourceName: "icon_login_user_name")
        
        
        //密码图
        let imgLock2 =  UIImageView(frame:CGRect(x:formViewHeight/8, y:formViewHeight/8, width:formViewHeight/4, height:formViewHeight/4))
        imgLock2.image = UIImage(named:"icon_login_password")
        // imgLock2.image = #imageLiteral(resourceName: "icon_login_password")
        self.account.leftView = UIView(frame:CGRect(x:0, y:0, width:formViewHeight/2-1, height:formViewHeight/2-1))
        self.account.leftViewMode = UITextFieldViewMode.always
        self.account.returnKeyType = UIReturnKeyType.next
        
        //用户名输入框左侧图标
        self.account.leftView!.addSubview(imgLock1)
        self.pwdTf.leftView = UIView(frame:CGRect(x:0, y:0, width:formViewHeight/2-1, height:formViewHeight/2-1))
        self.pwdTf.leftViewMode = UITextFieldViewMode.always
        self.pwdTf.returnKeyType = UIReturnKeyType.done
        
        //密码输入框左侧图标
        self.pwdTf.leftView!.addSubview(imgLock2)
        
    }
    @IBAction func registeAccount(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisteViewController(), animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.account{
            account.resignFirstResponder()
            pwdTf.becomeFirstResponder()
            
        }
        else{
            pwdTf.resignFirstResponder()
          self.Loginbtn.sendActions(for:.touchUpInside )

        }
       
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       // pwdTf.resignFirstResponder()
        account.becomeFirstResponder()
    }
    //添加手势
    func addTap() {
        for tag in 201...207 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(_:)))
            let imageView = self.view.viewWithTag(tag)
            imageView?.isUserInteractionEnabled = true
            imageView?.addGestureRecognizer(tap)
        }
    }
    func tap(_ sender:UITapGestureRecognizer) {
        let n = sender.view?.tag
        switch n! {
        case 203:
            OpenShare.weiboAuth("all", redirectURI: "http://openshare.gfzj.us/", success: { (message) in
                let alertController = UIAlertController(title: "系统提示",
                                                        message: "登陆成功\(message)", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                }, fail: { (message, error) in
                    let alertController = UIAlertController(title: "系统提示",
                                                            message: "登陆失败\(message)", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                    
            })
            print("微博登录")
            
            
        case 201:
            OpenShare.qqAuth("get_user_info", success: { (message) in
                let alertController = UIAlertController(title: "系统提示",
                                                        message: "登陆成功\(message)", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                }, fail: { (message, error) in
                    let alertController = UIAlertController(title: "系统提示",
                                                            message: "登陆失败\(message)", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
            })
            print("QQ登录")
            
        case 202:
            print("微信登录")
            OpenShare.weixinAuth("snsapi_userinfo", success: { (message) in
                let alertController = UIAlertController(title: "系统提示",
                                                        message: "登陆成功\(message)", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
                }, fail: { (message, error) in
                    let alertController = UIAlertController(title: "系统提示",
                                                            message: "登陆失败\(message)", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
            })
        case 206:
            
            let alertController = UIAlertController(title: "系统提示",
                                                    message: "您确定要要退出程序吗？", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let okAction = UIAlertAction(title: "确定", style: .default, handler: {
                action in
                exit(0)
            })
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        default:
            print("帮助")
        }
    }
    @IBAction func logInBtn(_ sender: AnyObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.present(appDelegate.drawer, animated: true, completion: nil)
        print("登录成功，进入主界面")
    }
    @IBAction func toMain(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.present(appDelegate.drawer, animated: true, completion: nil)    }
    func rightViewBtn() {
        print("帮助")
    }
    
    
    //注册账号
    @IBAction func RegisterAccount(_ sender: AnyObject) {
        
        let myregisterview = MyRegister()
        
        //从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
        self.present(myregisterview, animated: true, completion: nil)
    }
    
    //找回密码
    @IBAction func FindPassword(_ sender: AnyObject) {
        
        let setpasswordview = SetPasswordViewController()
        let setpasswordnav = UINavigationController.init(rootViewController: setpasswordview)
        //从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
        self.present(setpasswordnav, animated: true, completion: nil)
        
    }
    
    //密码框的密码可见与不可见
    func eyes() {
        let btn = UIButton(type: .custom)
        btn.tag = 10
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        btn.setImage(UIImage(named:"ZYF-Register-eyeClose" ), for: UIControlState())
        btn.addTarget(self, action: #selector(self.btnClick), for: .touchUpInside)
        pwdTf.rightView = btn
        pwdTf.rightViewMode = .always
        
    }
    func btnClick() {
        let btn = self.view.viewWithTag(10) as! UIButton
        if pwdTf.isSecureTextEntry == true {
            pwdTf.isSecureTextEntry = false
            btn.setImage(UIImage(named: "ZYF-Register-eyeOpen"), for: UIControlState())
        } else {
            pwdTf.isSecureTextEntry = true
            btn.setImage(UIImage(named:"ZYF-Register-eyeClose" ), for: UIControlState())
        }
    }
}
