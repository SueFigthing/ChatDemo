//
//  MoreBtn.swift
//  ChatDemo
//
//  Created by lisue on 16/10/26.
//  Copyright © 2016年 lisue. All rights reserved.
//
/*
 * 自定义 Btn上的图片以及lable的位置
 */

import UIKit
private let  KItemIconWidth  =  54
private let KMarginIconTitle =  5

class MoreBtn: UIButton {

    override init(frame:CGRect){
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .center
       self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: (self.frame.width-CGFloat(KItemIconWidth))/2, y: 0.0, width:CGFloat(KItemIconWidth) , height: CGFloat(KItemIconWidth))
        self.titleLabel?.frame = CGRect(x: 0, y: (self.imageView?.frame.maxY)! + CGFloat(KMarginIconTitle), width:self.frame.width , height: (self.titleLabel?.font.pointSize)!)
    }

}
