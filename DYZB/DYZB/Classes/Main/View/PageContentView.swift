//
//  PageContentView.swift
//  DYZB
//
//  Created by xuwenrou on 2017/6/19.
//  Copyright © 2017年 xuwenrou. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    //定义属性
    fileprivate weak var parentViewController :UIViewController?
    
    fileprivate var childVCs:[UIViewController]
    
    //懒加载
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建collectionview
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
//        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
        
    }()
    
    

    init(frame: CGRect,childVCs:[UIViewController],parentViewController:UIViewController?) {
        
        self.childVCs = childVCs
        
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


 //MARK --设置UI界面
extension PageContentView {
    
    fileprivate func setupUI(){
    
        //1.将所有的子控制器添加父控制器中文
        for childVC in childVCs {
            
            parentViewController?.addChildViewController(childVC)
        }
        
        //2.添加collectionView,用于在cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView:UICollectionViewDataSource{
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVCs.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        let childVC = childVCs[indexPath.item]
        
        childVC.view.frame = cell.contentView.bounds
        
        cell.contentView.addSubview(childVC.view)
        
        return cell
    }
    
}

 //MARK --对外暴露的方法
extension PageContentView{
    
    func setCurrentIndex(currentIndex:Int) {
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.contentOffset = CGPoint(x: offsetX, y: 0)
        
    }
    
    
    
    
}
