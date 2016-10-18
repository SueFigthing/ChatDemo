//
//  ChatTabBarController.swift
//  ChatDemo
//
//  Created by lisue on 16/10/18.
//  Copyright © 2016年 lisue. All rights reserved.
//

import UIKit

//全局的常量
let singleTabBar = ChatTabBarController()

let itemAy = [["首页","tabbar_home"],
              ["我","tabbar_mine"]]

class ChatTabBarController: UITabBarController {
    
    //MARK: - 单例类
    class var sharedTabBarController:ChatTabBarController {
        
        return singleTabBar
        
    }
    
    
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let homeVC = ViewController()
        homeVC.title = "首页"
        let homeNav = UINavigationController(rootViewController: homeVC)
        
        let myVC  = MyTableViewController(style: .plain)
        myVC.title = "我"
        let myNav = UINavigationController(rootViewController: myVC)
        
        self.viewControllers = [homeNav,myNav]
        
        self.reSetItemImage()
        
        // Do any additional setup after loading the view.
    }
    
     //MARK: - 设置item 图片
    /// 设置tabBarItem 点击与未点击时候的背景图片
    func reSetItemImage() -> Void {
        let ay = self.viewControllers
        
        for (index,item) in (ay?.enumerated())!
        {
            let itemAry = itemAy[index] as NSArray
            let title = itemAry[0] as! String
            let imageName = itemAry[1] as! String
            
            item.title = title
            item.tabBarItem.image = UIImage(named: imageName + "_n")
            item.tabBarItem.selectedImage = UIImage(named: imageName + "_h")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
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
