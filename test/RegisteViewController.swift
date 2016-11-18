//
//  RegisteViewController.swift
//  JSByZYF
//
//  Created by zhyunfe on 16/9/22.
//  Copyright © 2016年 zhyunfe. All rights reserved.
//

import UIKit

class RegisteViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var cancel: UIImageView!

    @IBOutlet weak var accTf: UITextField!
    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var privatePolicy: UILabel!
    @IBOutlet weak var usrProtocol: UILabel!
    @IBOutlet weak var pwdTf: UITextField!
    @IBOutlet weak var rePws: UILabel!
    @IBOutlet weak var pwd: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let arr = [rePws,name,pwd]
        for i in arr {
            i?.layer.borderWidth = 1
            i?.layer.borderColor = UIColor.init(red: 238 / 255, green: 238 / 255, blue: 238 / 255, alpha: 1).cgColor
        }
        addGeste()
        addUsrPo()
        addpriTap()
        eyes()
        self.navigationController?.navigationBar.isHidden = true
    }
    //取消按钮手势
    func addGeste() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.cancelTap))
        cancel.addGestureRecognizer(tap)
    }
    //取消按钮
    func cancelTap() {
        self.navigationController?.popViewController(animated: true)
    }

    //用户协议手势
    func addUsrPo() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.usrTap))
        usrProtocol.addGestureRecognizer(tap)
    }
    func usrTap() {

        //用户协议界面Loading……
        print("用户协议")
    }

    //隐私政策手势
    func addpriTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.priTap))
        privatePolicy.addGestureRecognizer(tap)
    }

    func priTap() {
        //隐私政策界面Loading……
        print("隐私政策")
    }

    //注册按钮
    @IBAction func registeBtn(_ sender: UIButton) {
        print("注册简书账号")
    }

    //随便看看
    @IBAction func intoMain(_ sender: UIButton) {
        //随便看看Loading……
       // self.navigationController?.pushViewController(MainView(), animated: true)
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pwdTf.resignFirstResponder()
        nameTf.resignFirstResponder()
        accTf.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pwdTf.resignFirstResponder()
        nameTf.resignFirstResponder()
        accTf.resignFirstResponder()
    }

}
