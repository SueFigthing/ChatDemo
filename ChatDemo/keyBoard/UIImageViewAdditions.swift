//
//  UIImageViewAdditions.swift
//  ChatDemo
//
//  Created by lisue on 16/10/28.
//  Copyright © 2016年 lisue. All rights reserved.
//

//根据颜色生成相应的图片

import UIKit

extension UIImage{
    class func imageWithColor(color:UIColor) -> UIImage {
        return UIImage.imageWithColor(color: color, size: CGSize(width: 1.0, height: 1.0))
    }
    
   fileprivate class  func imageWithColor(color:UIColor,size:CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}


class UIImageViewAdditions: NSObject {

}
