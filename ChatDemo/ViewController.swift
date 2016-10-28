//
//  ViewController.swift
//  ChatDemo
//
//  Created by lisue on 16/10/18.
//  Copyright © 2016年 lisue. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let btn = UIButton(type: .custom)
        self.view.addSubview(btn)
        btn.backgroundColor = UIColor.red
        
        btn.snp.makeConstraints({(make:ConstraintMaker) -> Void in
            make.top.equalTo(self.view).offset(100)
            make.left.equalTo(self.view).offset(100)
            make.right.equalTo(self.view).offset(-100)
            make.height.equalTo(100)
        })
   
        btn.addTarget(self, action: #selector(action), for: .touchUpInside)

//        
//        let keyboard = SEKeyBoard(frame:CGRect.zero)
//        self.view.addSubview(keyboard)
//        keyboard.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(100)
//            make.left.right.equalTo(self.view)
//        }
//        

        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func action() -> Void {
        let chat = ChatTableViewController()
        chat.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chat, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

