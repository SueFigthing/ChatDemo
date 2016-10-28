//
//  LRecordVoiceBtn.swift
//  ChatDemo
//
//  Created by lisue on 16/10/28.
//  Copyright © 2016年 lisue. All rights reserved.
//

import UIKit

class LRecordVoiceBtn: UIButton {
   override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  fileprivate  func setUI() -> Void {
        
        self.setTitle("按住 说话", for: .normal)
        self.setTitle("松开 结束", for: .highlighted)
        self.setTitle("按住 说话", for: .disabled)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        self.addTarget(self, action: #selector(LRecordVoiceBtn.holdDownButtonTouchDown(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(LRecordVoiceBtn.holdDownButtonTouchUpInside(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(LRecordVoiceBtn.holdDownButtonTouchUpOutside(sender:)), for: .touchUpOutside)
        self.addTarget(self, action: #selector(LRecordVoiceBtn.holdDownDragOutside(sender:)), for: .touchDragExit)
        self.addTarget(self, action: #selector(LRecordVoiceBtn.holdDownDragInside(sender:)), for: .touchDragEnter)
        let imgN = UIImage.imageWithColor(color: UIColor.black.withAlphaComponent(0.02))
        let imgH = UIImage.imageWithColor(color: UIColor.black.withAlphaComponent(0.06))
        //
        self.setBackgroundImage(imgN, for: .normal)
        self.setBackgroundImage(imgH, for: .highlighted)
        self.setBackgroundImage(imgH, for: .disabled)
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        self.setTitleColor(UIColor.black.withAlphaComponent(0.7), for: .normal)

    }
    
    func holdDownButtonTouchDown(sender:UIButton) -> Void {
        
    }
    
    func holdDownButtonTouchUpInside(sender:UIButton) -> Void {
        
    }
    
    func holdDownButtonTouchUpOutside(sender:UIButton) -> Void {
        
    }
    
    func holdDownDragOutside(sender:UIButton) -> Void {
        
    }
    
    func holdDownDragInside(sender:UIButton) -> Void {
        
    }
    
 

}
