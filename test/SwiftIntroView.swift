//
//  SwiftIntroViewViewController.swift
//  test
//
//  Created by 陈小爷 on 2016/11/1.
//  Copyright © 2016年 陈小爷. All rights reserved.
//

import UIKit
import SnapKit



class SwiftIntroView: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var doneButton: UIButton!
    var lijitiyanButton: UIButton!
    
    var view1: UIImageView!
    var view2: UIImageView!
    var view3: UIImageView!
    var view4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initScrollView()
        self.initPageViews()
        self.initPageControl()
        self.initDoneButton()
        self.addButton()
    }

    //初始化 scrollView
    func initScrollView() {
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        // 控制垂直方向遇到边框是否反弹
        scrollView.alwaysBounceVertical = false
        // 控制水平方向遇到边框是否反弹
        scrollView.alwaysBounceHorizontal = false
        // 是否显示水平滚动条
        scrollView.showsHorizontalScrollIndicator = false
        // 是否显示垂直滚动条
        scrollView.showsVerticalScrollIndicator = false
        // 是否可以滚动
        scrollView.isScrollEnabled = true
        //  控制控件遇到边框是否反弹
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * 4, height: scrollView.frame.size.height)
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        self.view.addSubview(scrollView)
    }
    
    //初始化页面视图 - 可根据需要自己增加控件
    func initPageViews() {
        
        let originW = self.view.frame.size.width
        
        view1 = UIImageView(frame: self.view.frame)
        view1.frame.origin.x = originW * 0
        
        view2 = UIImageView(frame: self.view.frame)
        view2.frame.origin.x = originW * 1
        
        view3 = UIImageView(frame: self.view.frame)
        view3.frame.origin.x = originW * 2
        
        view4 = UIImageView(frame: self.view.frame)
        view4.frame.origin.x = originW * 3
        
        view1.image = UIImage(named: "guideImage1")
        view2.image = UIImage(named: "guideImage2")
        view3.image = UIImage(named: "guideImage3")
        view4.image = UIImage(named: "guideImage4")
        
        self.scrollView.addSubview(view1)
        self.scrollView.addSubview(view2)
        self.scrollView.addSubview(view3)
        self.scrollView.addSubview(view4)
    }
    
    //初始化 pageControl
    func initPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.size.height - 80, width: self.view.frame.size.width, height: 10))
        pageControl.currentPageIndicatorTintColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 0.8)
        pageControl.numberOfPages = 4
        self.view.addSubview(pageControl)
    }
    
    //初始化 DoneButton
    func initDoneButton() {
        doneButton = UIButton(frame: CGRect(x: self.view.frame.size.width - 70, y: 50, width: 50, height: 30))
        doneButton.setTitle("跳过", for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        doneButton.backgroundColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 0.0)
        //增加点击事件并交给代理去完成
        doneButton.addTarget(self, action: #selector(doneButtonClick),
                                     for: .touchUpInside)
      //  doneButton.addTarget(self.delegate, action: Selector(("doneButtonClick")), for: .touchUpInside)
        self.view.addSubview(doneButton)
    }
    
    //实现 UIScrollViewDelegate 方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = self.view.frame.width
        let pageFraction = self.scrollView.contentOffset.x / pageWidth
        self.pageControl.currentPage = Int(roundf(Float(pageFraction)))
        if self.pageControl.currentPage==3 {
            doneButton.alpha=0
            lijitiyanButton.alpha=1
        }
         else {
            doneButton.alpha=1
            lijitiyanButton.alpha=0

        }
    }
    func addButton(){

        //lijitiyanButton=UIButton(frame:CGRect(x:0, y:self.frame.size.height-70, width:80, height:40))
        lijitiyanButton=UIButton()
        lijitiyanButton.setTitle("立即体验", for: .normal)
        lijitiyanButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        lijitiyanButton.backgroundColor = UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 0)
        //增加点击事件并交给代理去完成
        lijitiyanButton.addTarget(self, action: #selector(doneButtonClick),
                             for: .touchUpInside)
      //  lijitiyanButton.addTarget(self.delegate, action: Selector(("doneButtonClick")), for: .touchUpInside)
        lijitiyanButton.alpha=0
        self.view.addSubview(lijitiyanButton)
        self.lijitiyanButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.bottom.equalTo(-90)
            make.right.equalTo(-15)
            make.height.equalTo(60)
        }

    }
    
    func  doneButtonClick(){
    
        let loginview = LoginView()
        
        //从下弹出一个界面作为登陆界面，completion作为闭包，可以写一些弹出loginView时的一些操作
        self.present(loginview, animated: true, completion: nil)
    }
}
