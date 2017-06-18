//
//  MainViewController.swift
//  DYZB
//
//  Created by xuwenrou on 2017/6/18.
//  Copyright © 2017年 xuwenrou. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        addChildVC(storyNames: ["Home","Live","Follow","Profile"])
        

        
    }
    
    private func addChildVC(storyNames:Array<String>){
        
        for storyName in storyNames {
            
            let ChildVC = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!;
            
            addChildViewController(ChildVC)
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
