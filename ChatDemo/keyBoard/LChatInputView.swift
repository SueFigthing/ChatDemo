//
//  LChatInputView.swift
//  ChatDemo
//
//  Created by lisue on 16/10/20.
//  Copyright © 2016年 lisue. All rights reserved.
//

import UIKit
let keyboardAnimationDuration = 0.23

enum KeyBoardType :Int{
    
    case Nomal = 10
    case VoiceRecoder = 11   //录音
    case More = 12           //更多
    case System = 13       //系统键盘
}

class LChatInputView: UIView {
    var saveTextViewStr = String()
    var voiceSwitchBtn:UIButton!
    var  textView:UITextView!
    var moreSwitchBtn: UIButton!
    var inputWrapView : UIView!
    var moreView:UIView!
    var recordVoiceBtn :UIButton!
    var keyBoardType :KeyBoardType!
    
  override  init(frame: CGRect) {
        super.init(frame: frame)
    self.backgroundColor = UIColor.white
      keyBoardType = KeyBoardType.Nomal
    
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   fileprivate func setupViews() -> Void {
    
    // 更多功能展示
    self.moreView = UIView()
    self.addSubview(self.moreView!)
    self.moreView.backgroundColor = UIColor.yellow
  
    self.inputWrapView = UIView()
    self.inputWrapView.backgroundColor = UIColor.yellow
    self.addSubview(inputWrapView)
    
    
    moreView?.snp.makeConstraints({ (make) -> Void in
        make.left.right.equalTo(self)
        make.height.equalTo(0)
        make.bottom.equalTo(self.snp.bottom)
        make.top.equalTo(self.inputWrapView.snp.bottom)
    })
    
    
    self.inputWrapView.snp.makeConstraints { (make) in
        make.left.right.top.equalTo(self)
        make.bottom.equalTo(inputWrapView.snp.top)
        make.height.equalTo(35)
    }
    //切换语音按钮
    
    self.voiceSwitchBtn = UIButton()
    self.voiceSwitchBtn.backgroundColor = UIColor.red
    self.addSubview(self.voiceSwitchBtn)
    self.voiceSwitchBtn.addTarget(self, action: #selector(LChatInputView.voiceSwitchAction), for:.touchUpInside)
    voiceSwitchBtn.snp.makeConstraints { (make) in
        make.left.equalTo(inputWrapView).offset(4)
        make.bottom.equalTo(inputWrapView).offset(-4)
        make.size.equalTo(CGSize(width: 27, height: 27))
    }
    
    // 切换更多的按钮
    
    self.moreSwitchBtn = UIButton()
    self.moreSwitchBtn.backgroundColor = UIColor.orange
    self.moreSwitchBtn.addTarget(self, action: #selector(LChatInputView.moreSwitchAction), for: .touchUpInside)
    self.addSubview(self.moreSwitchBtn)
    moreSwitchBtn.snp.makeConstraints { (make) in
        make.right.equalTo(inputWrapView).offset(-4)
        make.bottom.equalTo(inputWrapView).offset(-4)
        make.size.equalTo(CGSize(width: 27, height: 27))
    }
    
    
    self.textView = UITextView()
    self.textView.layer.borderColor = UIColor.lightGray.cgColor
    self.textView.layer.borderWidth = 0.5
    self.textView.layer.cornerRadius = 2
    self.textView.returnKeyType = .send
    self.textView.backgroundColor = UIColor.red
    self.textView.delegate = self
    self.textView.enablesReturnKeyAutomatically = true
    self.addSubview(self.textView)
    
    textView.snp.makeConstraints { (make) in
        
        make.right.equalTo(self.moreSwitchBtn.snp.left).offset(-5)
        make.left.equalTo(self.voiceSwitchBtn.snp.right).offset(5)
        make.top.equalTo(self.inputWrapView).offset(5)
        make.bottom.equalTo(self.inputWrapView).offset(-5)
        
        make.height.greaterThanOrEqualTo(30)
        make.height.lessThanOrEqualTo(100)
        make.height.equalTo(35)
    }
    self.updateInputTextViewHeight(self.textView)
    
  
    //录音
    
    self.recordVoiceBtn = UIButton()
    self.addSubview(self.recordVoiceBtn)
    self.recordVoiceBtn.backgroundColor = UIColor.red
    self.recordVoiceBtn.isHidden = true
    self.recordVoiceBtn.setTitle("按住 说话", for: UIControlState())
    self.recordVoiceBtn.setTitle("松开 结束", for: .highlighted)
    self.recordVoiceBtn.addTarget(self, action: #selector(LChatInputView.holdDownButtonTouchDown), for: .touchDown)
    self.recordVoiceBtn.addTarget(self, action: #selector(LChatInputView.holdDownButtonTouchUpInside), for: .touchUpInside)
    self.recordVoiceBtn.addTarget(self, action: #selector(LChatInputView.holdDownButtonTouchUpOutside), for: .touchUpOutside)
    self.recordVoiceBtn.addTarget(self, action: #selector(LChatInputView.holdDownDragOutside), for: .touchDragExit)
    self.recordVoiceBtn.addTarget(self, action: #selector(LChatInputView.holdDownDragInside), for: .touchDragEnter)
    self.recordVoiceBtn.snp.makeConstraints { (make) -> Void in
        make.right.equalTo(self.moreSwitchBtn.snp.left).offset(-5)
        make.left.equalTo(self.voiceSwitchBtn.snp.right).offset(5)
        make.top.equalTo(inputWrapView).offset(5).priority(1000)    //priorityRequired()
        make.bottom.equalTo(inputWrapView).offset(-5)
        make.height.equalTo(35).priority(250)
    }
    

    
    
    }
 
    func hideKeyBoardAnimation() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
    
}

//MARK: - 录音
extension LChatInputView{
    func holdDownButtonTouchDown() {
    }
    
    
    func holdDownButtonTouchUpInside() {
    }
    
    func holdDownButtonTouchUpOutside() {
    }
    
    func holdDownDragOutside() {
    }
    
    func holdDownDragInside() {
    }
    
//    ---------------------
    
    func voiceSwitchAction() -> Void {
        if keyBoardType == .More {
            self.moreView.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(0)
            }
        }
       
        
        if keyBoardType != .VoiceRecoder{
            keyBoardType = .VoiceRecoder
        }
        else{
            keyBoardType = .System
        }
        
       
        
        if keyBoardType != .VoiceRecoder{
            self.recordVoiceBtn.isHidden = true
            self.textView.isHidden = false
            if self.saveTextViewStr.characters.count>0 {
                self.textView.text = self.saveTextViewStr
                self.saveTextViewStr = ""
            }
            self.updateInputTextViewHeight(self.textView)
            self.textView.becomeFirstResponder()
            
        }else{
            self.recordVoiceBtn.isHidden = false
            self.textView.isHidden = true
            self.textView.resignFirstResponder()
            if self.textView.text.characters.count>0  {
                self.saveTextViewStr = self.textView.text
                self.textView.text = "";
                self.updateInputTextViewHeight(self.textView)
            }
           
        }
        
        self.voiceSwitchBtn.isSelected = !self.voiceSwitchBtn.isSelected;
    }
    
    func moreSwitchAction() -> Void {
        
        
        if keyBoardType == .VoiceRecoder {
            if self.saveTextViewStr.characters.count>0 {
                self.textView.text = self.saveTextViewStr
                self.saveTextViewStr = ""
                let textContentH = self.textView.contentSize.height
                if textContentH>35{
                    let textHeight = textContentH<100 ? textContentH:100
                    self.textView.snp.updateConstraints({ (make) -> Void in
                        make.height.equalTo(textHeight)
                    })
                }
            }
        }
        
        if keyBoardType != .More{
            keyBoardType = .More
        }
        else{
            keyBoardType = .System
        }
        
       
        self.recordVoiceBtn.isHidden = true
        self.textView.isHidden = false
      
        if keyBoardType == .More {
            self.textView.resignFirstResponder()
            CATransaction.begin()
            hideKeyBoardAnimation()
            self.superview!.layoutIfNeeded()
            
            self.moreView.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(150)
            }
            
            UIView.animate(withDuration: keyboardAnimationDuration, animations: { () -> Void in

                self.superview!.layoutIfNeeded()
            }) 
            CATransaction.commit()
        }else{

            self.updateInputTextViewHeight(self.textView)
            self.textView.becomeFirstResponder()
        }
        
         self.moreSwitchBtn.isSelected = !self.moreSwitchBtn.isSelected
    }
}

//MARK: -
extension LChatInputView:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        self.updateInputTextViewHeight(textView)
    }
    
    func updateInputTextViewHeight(_ textView: UITextView) {
        let textContentH = textView.contentSize.height
        let textHeight = textContentH > 35 ? (textContentH<100 ? textContentH:100):31
        
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.textView.snp.updateConstraints({ (make) -> Void in
                make.right.equalTo(self.moreSwitchBtn.snp.left).offset(-5)
                make.left.equalTo(self.voiceSwitchBtn.snp.right).offset(5)
                make.top.equalTo(self.inputWrapView).offset(5)
                make.bottom.equalTo(self.inputWrapView).offset(-5)
                make.height.greaterThanOrEqualTo(30)
                make.height.lessThanOrEqualTo(100)
                make.height.equalTo(textHeight)
            })
        }
        
    }

    
}
