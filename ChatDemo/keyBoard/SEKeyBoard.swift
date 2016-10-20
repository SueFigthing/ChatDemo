//
//  SEKeyBoard.swift
//  ChatDemo
//
//  Created by lisue on 16/10/19.
//  Copyright © 2016年 lisue. All rights reserved.
//

// 语音 更多  文本


import UIKit

let margin = 10
let btnSize = 25

class SEKeyBoard: UIView {
  
    override init(frame: CGRect) {
        super.init(frame: frame)
    
//        self.frame = CGRect(x: 0, y: 300, width:self.frame.size.width , height: 49 )
        self.backgroundColor = UIColor.gray
        self.layoutCustomViews()
    }
    


    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func layoutCustomViews(){
      
        self.addSubview(voiceBtn)
        self.addSubview(moreBtn)
        self.addSubview(textView)
        
        voiceBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom).offset(-(margin))
            make.left.equalTo(self.snp.left).offset(margin)
            make.size.width.equalTo(btnSize)
            make.size.height.equalTo(btnSize)
        }
        
        
        moreBtn.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(self.snp.bottom).offset(-(margin))
            make.right.equalTo(self.snp.right).offset(-(margin))
            make.size.width.equalTo(btnSize)
            make.size.height.equalTo(btnSize)
        }

        textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(margin)
            make.bottom.equalTo(self.snp.bottom).offset(-(margin))
            make.left.equalTo(voiceBtn.snp.right).offset(margin)
            make.right.equalTo(moreBtn.snp.left).offset(-margin)
            make.height.greaterThanOrEqualTo(30)
            make.height.lessThanOrEqualTo(100)
            
        }
        
    }
    
    
    
    
    //语音
    lazy var voiceBtn:UIButton = {
    let voicebtn = UIButton(type: .custom)
        voicebtn.backgroundColor = UIColor.orange
     return voicebtn
    }()
    
    //更多
    
    lazy var moreBtn:UIButton = {
       
        let morebtn = UIButton(type: .custom)
        morebtn.backgroundColor = UIColor.yellow
        return morebtn
    }()
    
    
    //文本
    
    lazy var textView:UITextView = {
        let textview = UITextView()
        textview.backgroundColor = UIColor.purple
        return textview
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
