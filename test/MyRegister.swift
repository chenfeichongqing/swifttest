//
//  MyRegister.swift
//  test
//
//  Created by 陈小爷 on 2016/11/15.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class MyRegister: UIViewController {

    @IBOutlet weak var close: UIImageView!
    @IBOutlet weak var telephone: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var getcode: UIButton!
    
    var countdownTimer: Timer?
    
    var remainingSeconds: Int = 0 {
        willSet {
            getcode.setTitle(" \(newValue)秒后获取 ", for: .normal)
            
            if newValue <= 0 {
                getcode.setTitle(" 重新获取 ", for: .normal)
                isCounting = false
            }
        }
    }
    var isCounting = false {
        willSet {
            if newValue {
                countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                
                remainingSeconds = 60
                
                getcode.backgroundColor = UIColor.gray
            } else {
                countdownTimer?.invalidate()
                countdownTimer = nil
                
                getcode.backgroundColor = UIColor.blue
            }
            
            getcode.isEnabled = !newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closewindow))
        close.isUserInteractionEnabled = true
        close.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    func closewindow(){
        self.dismiss(animated: true) { () -> Void in
        }
    }
    @IBAction func getAuthCode(_ sender: AnyObject) {
        
        let phoneNum = telephone.text
        if isTelNumber(num: phoneNum!){
            isCounting = true
            // 第三方验证
            SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: phoneNum, zone: "86", customIdentifier: nil) { (error) in
                if error == nil {
                    
                    self.view.makeToast("验证码发送成功")
                    
            
                } else {
                    
                    self.view.makeToast("验证码发送失败")
                    print("有错误:\(error)")
                }
            }
        
        }
        else{
        
             self.view.makeToast("请输入正确的手机号码")
        
        }
       
        
    }
    @IBAction func reCaptchaClick(_ sender: AnyObject) {
        let phoneNum = telephone.text
        let code = self.code.text
        SMSSDK.commitVerificationCode(code, phoneNumber: phoneNum, zone: "86") { (myuserinfo, error) in
            if (error == nil) {
                print("验证成功")
                self.view.makeToast("验证成功")
                let setpasswordview = SetPasswordViewController()
                let setpasswordnav = UINavigationController.init(rootViewController: setpasswordview)
                //从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
                self.present(setpasswordnav, animated: true, completion: nil)
                
            } else {
                self.remainingSeconds=0
                self.view.makeToast("验证失败")
                print("验证失败")
            }

        }
        
}
    //验证码倒计时
    func updateTime(timer: Timer) {
        remainingSeconds -= 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func isTelNumber(num:String)->Bool
    {
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }  
    }

}
