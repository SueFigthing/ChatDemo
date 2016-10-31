//
//  LChatInputView.swift
//  ChatDemo
//
//  Created by lisue on 16/10/20.
//  Copyright © 2016年 lisue. All rights reserved.
//

import UIKit



let moreViewHeight = 20+(moreViewBtnHeight + 15)*2
let keyboardAnimationDuration = 0.25
private let textViewHeight = 100

enum KeyBoardType :Int{
    
    case Nomal = 10
    case VoiceRecoder = 11   //录音
    case More = 12           //更多
    case System = 13       //系统键盘
}

class LChatInputView: UIView {
    
   fileprivate var saveTextViewStr = String()
   fileprivate var voiceSwitchBtn:UIButton!
   fileprivate var textView:UITextView!
   fileprivate var moreSwitchBtn: UIButton!
   fileprivate var inputWrapView : UIView!
    var moreView:MoreView!
   fileprivate var recordVoiceBtn :LRecordVoiceBtn!
    var keyBoardType :KeyBoardType!
    
    ///重写init方法
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
    self.moreView = MoreView(frame:CGRect.zero)
    self.addSubview(self.moreView!)
    self.moreView.backgroundColor = UIColor.yellow
    
    self.moreView.setItemsArr(itemsArr: [MoreViewType.Photo,MoreViewType.Camera,MoreViewType.Photo,MoreViewType.Camera,MoreViewType.Photo,MoreViewType.Camera,MoreViewType.Photo,MoreViewType.Camera,MoreViewType.Photo,MoreViewType.Camera,MoreViewType.Photo,MoreViewType.Camera,MoreViewType.Photo,MoreViewType.Camera]
)
    
    
    
    //inputBar的背景
    self.inputWrapView = UIView()
    self.inputWrapView.backgroundColor = UIColor.clear
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
    self.addSubview(self.voiceSwitchBtn)
    self.voiceSwitchBtn.setImage(UIImage.init(named: "btn_voice_n"), for: .normal)
    self.voiceSwitchBtn.setImage(UIImage.init(named: "btn_keyboard_n"), for: .selected)
    self.voiceSwitchBtn.addTarget(self, action: #selector(LChatInputView.voiceSwitchAction), for:.touchUpInside)
    
    voiceSwitchBtn.snp.makeConstraints { (make) in
        make.left.equalTo(inputWrapView).offset(4)
        make.bottom.equalTo(inputWrapView).offset(-4)
        make.size.equalTo(CGSize(width: 27, height: 27))
    }
    
    // 切换更多的按钮
    self.moreSwitchBtn = UIButton()
    self.moreSwitchBtn.addTarget(self, action: #selector(LChatInputView.moreSwitchAction), for: .touchUpInside)
    self.addSubview(self.moreSwitchBtn)
    
    self.moreSwitchBtn.setImage(UIImage.init(named: "btn_more_n"), for: .normal)
    self.moreSwitchBtn.setImage(UIImage.init(named: "btn_more_h"), for: .highlighted)
    
    moreSwitchBtn.snp.makeConstraints { (make) in
        make.right.equalTo(inputWrapView).offset(-4)
        make.bottom.equalTo(inputWrapView).offset(-4)
        make.size.equalTo(CGSize(width: 27, height: 27))
    }
    
    //输入框
    self.textView = UITextView()
    self.textView.layer.borderColor = UIColor.lightGray.cgColor
    self.textView.layer.borderWidth = 0.5
    self.textView.layer.cornerRadius = 5
    self.textView.layoutManager.allowsNonContiguousLayout = false;
    self.textView.textContainerInset = UIEdgeInsetsMake(3, 3, 10, 3);
    self.textView.returnKeyType = .send
    self.textView.backgroundColor = UIColor.white
    self.textView.delegate = self
    self.textView.enablesReturnKeyAutomatically = true
    self.textView.scrollsToTop = false
    self.textView.isDirectionalLockEnabled = true;
    self.textView.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(self.textView)
    
    textView.snp.makeConstraints { (make) in
        make.right.equalTo(self.moreSwitchBtn.snp.left).offset(-5)
        make.left.equalTo(self.voiceSwitchBtn.snp.right).offset(5)
        make.top.equalTo(self.inputWrapView).offset(5)
        make.bottom.equalTo(self.inputWrapView).offset(-5)
        make.height.greaterThanOrEqualTo(30)
        make.height.lessThanOrEqualTo(textViewHeight)
        make.height.equalTo(35)
    }
    self.updateInputTextViewHeight(self.textView)
    
  
    //录音
    self.recordVoiceBtn = LRecordVoiceBtn(frame: CGRect.zero)
    self.addSubview(self.recordVoiceBtn)
    self.recordVoiceBtn.isHidden = true
    self.recordVoiceBtn.snp.makeConstraints { (make) -> Void in
        make.right.equalTo(self.moreSwitchBtn.snp.left).offset(-5)
        make.left.equalTo(self.voiceSwitchBtn.snp.right).offset(5)
        make.top.equalTo(inputWrapView).offset(5).priority(1000)    //priorityRequired()
        make.bottom.equalTo(inputWrapView).offset(-5)
        make.height.equalTo(35).priority(250)
    }
    
    }
 
    /// 输入框失去焦点
    func hideKeyBoardAnimation() {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
    
}

//MARK: - 切换更多或者语音按钮
extension LChatInputView{
    
    ///点击语音 切换键盘与语音功能
    @objc fileprivate  func voiceSwitchAction() -> Void {
        
        if keyBoardType != .VoiceRecoder{
            keyBoardType = .VoiceRecoder
            self.moreView.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(0)
            }
            
            self.recordVoiceBtn.isHidden = false
            self.textView.isHidden = true
            self.textView.resignFirstResponder()
            if self.textView.text.characters.count>0  {
                self.saveTextViewStr = self.textView.text
                self.textView.text = "";
                self.updateInputTextViewHeight(self.textView)
            }

        }
        else{
            keyBoardType = .System
            self.recordVoiceBtn.isHidden = true
            self.textView.isHidden = false
            if self.saveTextViewStr.characters.count>0 {
                self.textView.text = self.saveTextViewStr
                self.saveTextViewStr = ""
            }
            self.updateInputTextViewHeight(self.textView)
            self.textView.becomeFirstResponder()

        }
        
        self.voiceSwitchBtn.isSelected = !self.voiceSwitchBtn.isSelected;
    }
    
    ///点击更多 切换键盘与更多功能
  @objc fileprivate  func moreSwitchAction() -> Void {
    
        if keyBoardType == .VoiceRecoder {
            self.voiceSwitchBtn.isSelected = false
            //这里处理有文本切切换发语音 要用saveTextViewStr保存当前的内容
            if self.saveTextViewStr.characters.count>0 {
                self.textView.text = self.saveTextViewStr
                self.saveTextViewStr = ""
                let textContentH = self.textView.contentSize.height
                if textContentH>35{
                    let textHeight = textContentH < CGFloat(textViewHeight)  ? textContentH:CGFloat(textViewHeight)
                    self.textView.snp.updateConstraints({ (make) -> Void in
                        make.height.equalTo(textHeight)
                    })
                    
                    if textContentH > CGFloat(textViewHeight) {
                        
                       self.textView.scrollRectToVisible(CGRect.init(x: 0, y: textView.contentSize.height-15, width: textView.contentSize.width, height: 15), animated: false)
                    }
                   
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
            CATransaction.begin()
            hideKeyBoardAnimation()
            self.superview!.layoutIfNeeded()
            
            self.moreView.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(moreViewHeight)
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



//MARK: - UITextViewDelegate
extension LChatInputView:UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.keyBoardType = .System
    }
    
    func textViewDidChange(_ textView: UITextView) {
        /*在ios7上出现编辑进入最后一行时光标消失，看不到最后一行  优化*/
        let line = textView.caretRect(for: (textView.selectedTextRange?.start)!)
        let overflow = line.origin.y + line.size.height
                    - ( textView.contentOffset.y + textView.bounds.size.height
                        - textView.contentInset.bottom - textView.contentInset.top )
        
        if overflow>0 {
            var offset = textView.contentOffset
            offset.y += overflow + 7
            
            UIView.animate(withDuration: 0.2, animations: {
                textView.setContentOffset(offset, animated: false)
            })
        }
        
        
        self.updateInputTextViewHeight(textView)
    }
    
    func updateInputTextViewHeight(_ textView: UITextView) {
        let textContentH = textView.contentSize.height
        let textHeight = textContentH > 35 ? (textContentH<CGFloat(textViewHeight) ? textContentH:CGFloat(textViewHeight)):31
        
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.textView.snp.updateConstraints({ (make) -> Void in
                make.right.equalTo(self.moreSwitchBtn.snp.left).offset(-5)
                make.left.equalTo(self.voiceSwitchBtn.snp.right).offset(5)
                make.top.equalTo(self.inputWrapView).offset(5)
                make.bottom.equalTo(self.inputWrapView).offset(-5)
                make.height.greaterThanOrEqualTo(30)
                make.height.lessThanOrEqualTo(textViewHeight)
                make.height.equalTo(textHeight)
            })
        }
    }
    
    //失去焦点
    func resignResponder() -> Void {
        
        if self.keyBoardType == .More {
            self.keyBoardType = .Nomal
            self.moreView.snp.updateConstraints { (make) -> Void in
                make.height.equalTo(0)
            }
        }
        else if self.keyBoardType != .VoiceRecoder{
            self.keyBoardType = .Nomal
           hideKeyBoardAnimation()
        }
       
    }
}
