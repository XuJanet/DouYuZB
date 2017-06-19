//
//  PageTitleView.swift
//  DYZB
//
//  Created by xuwenrou on 2017/6/18.
//  Copyright © 2017年 xuwenrou. All rights reserved.
//

import UIKit

protocol pageTitleViewDelegate:class {
    
    func pageTitleView(pageTitleView:PageTitleView,selectedIndex index:Int)
}

private let kScrollLineH:CGFloat = 2

private var currentIndex = 0

class PageTitleView: UIView {
    
     //MARK --定义属性
    fileprivate var titles:[String]
    
    weak var delegate:pageTitleViewDelegate?
    
     //MARK --懒加载
    
    fileprivate lazy var titleLabels:[UILabel] = [UILabel]()
    
    fileprivate lazy var scrollview : UIScrollView = {
        
        let scrollview = UIScrollView()
        
        scrollview.scrollsToTop = false
        
        scrollview.showsHorizontalScrollIndicator = false
        
        scrollview.bounces = false
        
        return scrollview
        
        }()
    
    fileprivate lazy var scrollLine:UIView = {
        
        let scrollLine = UIView()
        
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
        
    }()
    //MARK --自定义构造器
    
    init(frame: CGRect,titles:[String]) {
        
        self.titles = titles
        
        
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 //MARK --设置UI界面
extension PageTitleView {
    
   
    
    
    fileprivate func setupUI(){
        
        //1.添加UIScrollView
        addSubview(scrollview)
        scrollview.frame = bounds
        
        //2.添加title对应的Lable
        setupTitleLabel()
        
        //3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    fileprivate func setupTitleLabel(){
        
        let labelW = frame.width/CGFloat(titles.count)
        
        let labelH = frame.height - kScrollLineH
        
        let  labelY:CGFloat = 0
        
        
        for (index,title) in titles.enumerated() {
            
            //1.创建UILabel
            let label = UILabel()
            
            
            //2.设置Label的属性
            label.textColor = UIColor.darkGray
            
            label.tag = index
            
            label.font = UIFont.systemFont(ofSize: 16.0)
            
            label.textAlignment = .center
            
            label.text = title
            
            let labelX = labelW*CGFloat(index)
    
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            
            scrollview.addSubview(label)
            
            titleLabels.append(label)
            
            //给Label添加手势
            label.isUserInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClickGes(tapGes:)))
            
            label.addGestureRecognizer(tapGes)
            
        }
    
    }
    
    fileprivate func setupBottomLineAndScrollLine(){
        
        //1.添加底线
        let bottomLine = UIView()
        
        bottomLine.backgroundColor = UIColor.lightGray
        
        let LineH:CGFloat = 0.5
        
        bottomLine.frame = CGRect(x: 0, y: frame.height - LineH, width: frame.width, height: LineH)
        
        scrollview.addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1获取第一个Label
        guard let firstLabel = titleLabels.first else {
            return
        }
        
        firstLabel.textColor = UIColor.orange
        
        scrollview.addSubview(scrollLine)
        
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel
            .frame.width, height: kScrollLineH)
        
    }
    
}

extension PageTitleView{
    
    @objc fileprivate func titleLabelClickGes(tapGes:UITapGestureRecognizer){
        
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor.orange
        
        oldLabel.textColor = UIColor.darkGray
        
        let scrollLineX = scrollLine.frame.width * CGFloat(currentLabel.tag)
        
        currentIndex = currentLabel.tag
        
        delegate?.pageTitleView(pageTitleView: self, selectedIndex: currentIndex)
        
        UIView.animate(withDuration: 0.15) { 
            
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        
        
        
    }
}
