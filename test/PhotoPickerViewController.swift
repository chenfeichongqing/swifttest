//
//  PhotoPickerViewController.swift
//  XBook
//
//  Created by xlx on 15/12/11.
//  Copyright © 2015年 xlx. All rights reserved.
//

import UIKit

protocol PhotoPickerDelegate{
    func getImageFromPicker(image:UIImage)
}


class PhotoPickerViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
    
    var alert:UIAlertController?
    
    var picker:UIImagePickerController!
    
    var delegate:PhotoPickerDelegate!
    
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        
        self.view.backgroundColor = UIColor.clear
        
        
        self.picker = UIImagePickerController()
        self.picker.allowsEditing = false
        self.picker.delegate = self
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemeted")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(self.alert == nil){
            self.alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            self.alert?.addAction(UIAlertAction(title: "从相册选择", style: .default, handler: { (action) -> Void in
                self.localPhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "打开相机", style: .default, handler: { (action) -> Void in
               self.takePhoto()
            }))
            self.alert?.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) -> Void in
                
            }))
            self.present(self.alert!, animated: true, completion: { () -> Void in
                
            })
        }
    }
    /**
     打开相机
     */
    func takePhoto(){
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){
            
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: { () -> Void in
                
            })
            
        
        
        }else{
            let alertView = UIAlertController(title: "此机型无相机", message: nil, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "关闭", style: .cancel, handler: { (action) -> Void in
                self.dismiss(animated: true, completion: { () -> Void in
                    
                })
                
            }))
            self.present(alertView, animated: true, completion: { () -> Void in
                
            })
        }
    }
    /**
    *  打开相册
    */
    func localPhoto(){
        self.picker.sourceType = .photoLibrary
        self.present(self.picker, animated: true) { () -> Void in
            
        }
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.picker.dismiss(animated: true) { () -> Void in
            self.dismiss(animated: true, completion: { () -> Void in
                
            })
        }
    }
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.picker.dismiss(animated: true) { () -> Void in
            self.dismiss(animated: true, completion: { () -> Void in
                self.delegate.getImageFromPicker(image: image)
            })
        }
    }
    


}
