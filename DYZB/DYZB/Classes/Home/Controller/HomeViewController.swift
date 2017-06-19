//
//  HomeViewController.swift
//  DYZB
//
//  Created by xuwenrou on 2017/6/18.
//  Copyright © 2017年 xuwenrou. All rights reserved.
//

import UIKit

private let kTitleViewH :CGFloat = 40

class HomeViewController: UIViewController {
    
    
    fileprivate lazy var pageTitleView:PageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y: kStatusBarH+kNavgationBarH, width: kScreenW, height: kTitleViewH)
        
        let titles = ["推荐","游戏","娱乐","趣玩"]
        
        let pageTitleView = PageTitleView(frame: titleFrame, titles: titles)
        
        pageTitleView.delegate = self
        
        return pageTitleView
    }()
    
    fileprivate lazy var pageContentView:PageContentView = {[weak self] in
        
        let contentH = kScreenH - kStatusBarH - kNavgationBarH - kTitleViewH
        
        let contentFrame = CGRect(x: 0, y: kStatusBarH+kNavgationBarH+kTitleViewH, width: kScreenW, height: contentH)
        
        var childVCs = [UIViewController]()
        
        for _ in 0..<4{
            
            let vc = UIViewController()
            
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            
            childVCs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: contentFrame, childVCs: childVCs, parentViewController: self)
        
        return pageContentView
       
    }()

     //MARK --系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
       
    
    }
    

}


 //MARK --设置UI界面
extension HomeViewController {
    
    fileprivate func setupUI(){
        
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加pageTitleView
        view.addSubview(pageTitleView)
        
        //3.添加pageContentView
        view.addSubview(pageContentView)
    }
    
    fileprivate func setupNavigationBar(){
        
        automaticallyAdjustsScrollViewInsets = false
        
        //左item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //右item
        let size = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrodeItem]
        
    }
}

extension HomeViewController:pageTitleViewDelegate{
    
    func pageTitleView(pageTitleView: PageTitleView, selectedIndex index: Int) {
        
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
