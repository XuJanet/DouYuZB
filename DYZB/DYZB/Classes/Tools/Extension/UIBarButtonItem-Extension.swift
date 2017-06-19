//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by xuwenrou on 2017/6/18.
//  Copyright © 2017年 xuwenrou. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    class func createItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: .normal)
        
        btn.setImage(UIImage(named:highImageName), for: .highlighted)
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
        
    }
    
    //便利构造器
    convenience init(imageName:String,highImageName:String = "",size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        
        btn.setImage(UIImage(named:imageName), for: .normal)
        
        if highImageName != "" {
            
             btn.setImage(UIImage(named:highImageName), for: .highlighted)
            
        }
        
        if size == CGSize.zero {
            
            btn.sizeToFit()
            
        }else{
            
             btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
    
}
