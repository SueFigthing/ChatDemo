//
//  ChatTableViewController.swift
//  ChatDemo
//
//  Created by lisue on 16/10/18.
//  Copyright © 2016年 lisue. All rights reserved.
//

import UIKit

class ChatTableViewController: UIViewController {

    var tableView : UITableView!
    var messageInputView :LChatInputView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        let gesture = UITapGestureRecognizer(target: self, action:#selector(ChatTableViewController.handleTap(_:)))
        gesture.delegate = self
        self.tableView.addGestureRecognizer(gesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardFrameChanged(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    
   fileprivate func setupViews() -> Void {
        
        self.messageInputView = LChatInputView(frame: CGRect.zero)
        self.view.addSubview(messageInputView)
        
        self.messageInputView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
        }
        
        self.messageInputView.moreView.snp.makeConstraints { (make) -> Void in
          make.bottom.equalTo(self.view.snp.bottom)
        }
        
        self.tableView = UITableView()
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.red
        self.tableView.keyboardDismissMode = .interactive
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.messageInputView.snp.top)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - UIGestureRecognizerDelegate
extension ChatTableViewController:UIGestureRecognizerDelegate {
    
    func handleTap(_ recognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: keyboardAnimationDuration, animations: { () -> Void in
            self.view.layoutIfNeeded()
           
            self.messageInputView.resignResponder()
            
            self.view.layoutIfNeeded()
        }) 
    }
}

// MARK: - 键盘改变
extension ChatTableViewController {
    
    func keyboardFrameChanged(_ notification: Notification) {
        let dic = NSDictionary(dictionary: (notification as NSNotification).userInfo!)
        let keyboardValue = dic.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let bottomDistance = UIScreen.main.bounds.size.height - keyboardValue.cgRectValue.origin.y
        let duration = Double(dic.object(forKey: UIKeyboardAnimationDurationUserInfoKey) as! NSNumber)
        print("---\(self.messageInputView.keyBoardType)")
        if self.messageInputView.keyBoardType == .System ||  self.messageInputView.keyBoardType == .Nomal || bottomDistance>0{
            UIView.animate(withDuration: duration, animations: {
                self.messageInputView.moreView?.snp.updateConstraints({ (make) -> Void in
                    make.height.equalTo(bottomDistance)
                })
                self.view.layoutIfNeeded()
                }, completion: {
                    (value: Bool) in
            })
        }
    
        
    }
}

// MARK: - Table view data source
extension  ChatTableViewController :UITableViewDelegate,UITableViewDataSource{
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "deee")
        if cell==nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "deee")
        }
        
        return cell!
    
    
    }

  
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
