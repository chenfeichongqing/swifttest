//
//  mySliderViewController.swift
//  test
//
//  Created by 陈小爷 on 2016/10/27.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit

class mySliderViewController: UIViewController ,TouxiangDelegate , UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate {
    
    var headview : HeadView?
    var imagePicker : UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor(red: 13/255, green: 184/255, blue: 246/255, alpha: 1)
        print(KSCREEN.width)
        print(KSCREEN.height)
        
        headview = HeadView(frame: CGRect.init(x:0, y:0, width: KSCREEN.width-48, height: KSCREEN.height*0.5 - 60))
        
        let footview:FootView = FootView(frame: CGRect.init(x:0, y: KSCREEN.height-48, width: KSCREEN.width-48, height: 48))
        
        let letView:LeftTabelView = LeftTabelView(frame: CGRect(x:0, y: KSCREEN.height*0.5 - 60, width: KSCREEN.width-48, height: KSCREEN.height*0.6 - 48), style: UITableViewStyle.plain)
        
        
        self.view.addSubview(headview!)
        self.view.addSubview(letView)
        self.view.addSubview(footview)
        self.headview?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func choicetouxiang() {
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
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    func initWithImagePickView(type:NSString){
        
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true;
        
        switch type{
        case "拍照":
            self.imagePicker.sourceType = .camera
            break
        case "相册":
            self.imagePicker.sourceType = .photoLibrary
            break
        default:
            print("error")
        }
        
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.headview?.nameimage.image =  image;
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }

    }
    
    
