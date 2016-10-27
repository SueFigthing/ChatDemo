//
//  MoreView.swift
//  ChatDemo
//
//  Created by lisue on 16/10/25.
//  Copyright © 2016年 lisue. All rights reserved.
//

/*
 * [更多菜单栏的布局]
 */

// 对于这个界面 不采用约束  因为采用约束 太过繁琐

import UIKit

//选择卡选项
enum MoreViewType: Int {
    case Nomal = 1
    case Photo      //相册
    case Camera     //拍照
}

fileprivate let kMoreViewIconN = "kMoreViewIconN"
fileprivate let kMoreViewIconH = "kMoreViewIconH"
fileprivate let kMoreViewIconDisabled = "kMoreViewIconDisabled"
fileprivate let kMoreViewIconTitle = "kMoreViewIconTitle"
fileprivate let kMoreViewIconTag  = "kMoreViewIconTag"

fileprivate let itemPadding = 10   //间距
fileprivate let maxRowNum = 2      //最大行数
fileprivate let maxColumNum = 4    //最大列数
let moreViewBtnHeight = 72 //菜单按钮的宽高

let wid = UIApplication.shared.keyWindow?.bounds.size.width;

class MoreView: UIView {
   fileprivate var scrollview :UIScrollView!
   fileprivate var pagControl :UIPageControl!
   fileprivate var itemAy :NSMutableArray!
 
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        self.initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    fileprivate func initUI(){
        
        scrollview = UIScrollView(frame: CGRect(x: 0, y: 0, width: Int(wid!), height: moreViewHeight))
        scrollview.contentSize = CGSize(width: Int(wid!)*1, height: 0)
        scrollview.backgroundColor = UIColor.orange
        scrollview.delegate = self
        scrollview.isPagingEnabled = true
        scrollview.showsHorizontalScrollIndicator = false
        self.addSubview(scrollview)
        
        pagControl = UIPageControl(frame: CGRect(x: Int(wid!/2), y: moreViewHeight-15, width: 10, height: 10))
        pagControl.numberOfPages = Int(self.scrollview.contentSize.width)/Int(wid!);
        pagControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.6)
        pagControl.currentPageIndicatorTintColor = UIColor.gray
        pagControl.hidesForSinglePage = true
        self.addSubview(pagControl)
    }
    
   fileprivate func setupUI() {
        
        let w = wid! - CGFloat(itemPadding*(maxColumNum+1))
        let width = w/CGFloat(maxColumNum)
        
        for (i,item) in self.itemAy.enumerated(){
            let itemDic = item as! NSDictionary
             let btn = MoreBtn()
            let page = i/(maxRowNum*maxColumNum)
            btn.frame = self.getFrameWithColumesOfPerRow(columesOfPerRow: maxColumNum, rowsOfPerColumn: maxRowNum, itemWidth: width, itemHeight: CGFloat(moreViewBtnHeight), margin:CGFloat(itemPadding) , atIndex: i , page: page, scrollView: self.scrollview)
           
            
            let btnTag = (itemDic[kMoreViewIconTag] as! NSNumber).intValue
            let imageNameN = itemDic[kMoreViewIconN]
            let imageNameH = itemDic[kMoreViewIconH]
            let btnTitle = itemDic[kMoreViewIconTitle]
            btn.setImage(UIImage.init(named: imageNameN as! String ), for: .normal)
            btn.setImage(UIImage.init(named: imageNameH as! String), for: .highlighted)
            btn.setTitle(btnTitle as? String, for: .normal)
            btn.tag = btnTag 
            self.scrollview.addSubview(btn)
        }
        
    let countPerPage = (maxColumNum * maxRowNum);
    let pagesCount = ceil(Double(self.itemAy.count/countPerPage))
    self.scrollview.contentSize = CGSize(width: wid!, height: 0)
    self.pagControl.numberOfPages = Int(pagesCount);
    
    }
   
  ///按钮之间的布局
    fileprivate func getFrameWithColumesOfPerRow(columesOfPerRow:NSInteger,
                                     rowsOfPerColumn:NSInteger,
                                     itemWidth:CGFloat,
                                     itemHeight:CGFloat,
                                     margin:CGFloat,
                                     atIndex:NSInteger,
                                     page:NSInteger,
                                     scrollView:UIScrollView) -> CGRect {
        
        let xWid = CGFloat(atIndex % columesOfPerRow) * (itemWidth + margin)
        let x =   xWid + margin + (CGFloat(page) * wid!)
        
        let yHeight = (atIndex / columesOfPerRow) - rowsOfPerColumn * page
        
        let y = CGFloat(yHeight) * (itemHeight + margin) + margin
        
        let itemFrame = CGRect(x:x, y: y, width: itemWidth, height: itemHeight)
        
        return itemFrame
        
    }
    
    func setItemsArr(itemsArr:NSArray) -> Void {
        
        self.itemAy = NSMutableArray(capacity: 0)
        
        //加入菜单按钮选项
        for (_,item) in itemsArr.enumerated(){
            
            switch item as! MoreViewType {
            case .Photo:
                self.itemAy.add(self.photoItem())
                break
                
            case .Camera:
                self.itemAy.add(self.cameraItem())
                break
            default:
                 break
                
            }
        }
        
        for item in self.scrollview.subviews.enumerated() {
            
            item.element.removeFromSuperview()
            
        }
        
        //布局UI
        self.setupUI()
        
    }
    
}

// MARK: - 更多菜单的按钮配置数据
extension MoreView{
    
   fileprivate func photoItem() -> NSDictionary {
        
        let dic = [kMoreViewIconN:"btn_photo_n",
                   kMoreViewIconH:"btn_photo_h",
                   kMoreViewIconTitle:"相册",
                   kMoreViewIconTag:NSNumber.init(integerLiteral: MoreViewType.Photo.rawValue)] as [String : Any]
      return dic as NSDictionary
    }
    
   fileprivate func cameraItem() -> NSDictionary {
        
        let dic = [kMoreViewIconN:"btn_camera_n",
                   kMoreViewIconH:"btn_camera_h",
                   kMoreViewIconTitle:"拍照",
                   kMoreViewIconTag:NSNumber.init(integerLiteral: MoreViewType.Camera.rawValue)] as [String : Any]
        return dic as NSDictionary
    }
}

extension MoreView:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/wid!;
        self.pagControl.currentPage = Int(page);
    }
}
