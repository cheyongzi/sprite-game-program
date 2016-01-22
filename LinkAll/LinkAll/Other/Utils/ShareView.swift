//
//  ShareView.swift
//  LinkAll
//
//  Created by che on 15/11/23.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import UIKit

class ShareView: UIView {
    var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapGestureAction"))
        
        self.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        
        let shareTitlesArray = [NSLocalizedString("Friends", comment: ""),NSLocalizedString("weChat", comment: ""),"Facebook","Twitter"]
        let shareImgArray = ["friends-icon","wechat-icon","facebook","twitter"]
        
        contentView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: frame.size.height), size: CGSize(width: frame.size.width, height: 60)))
        contentView.backgroundColor = UIColor.whiteColor()
        addSubview(contentView)
        
        let length = (frame.size.width - 160) / 5
        
        for index in 0..<4 {
            let button = UIButton(type: .Custom)
            button.frame = CGRect(origin: CGPoint(x: length + CGFloat(index)*(40+length), y: 5), size: CGSize(width: 40, height: 40))
            button.backgroundColor = UIColor.clearColor()
            button.tag = index
            button.setImage(UIImage(named: shareImgArray[index]), forState: .Normal)
            button.addTarget(self, action: "buttonAction:", forControlEvents: .TouchUpInside)
            contentView.addSubview(button)
            
            let title = UILabel(frame: CGRect(origin: CGPointZero, size: CGSize(width: 50, height: 20)))
            title.center = CGPoint(x: button.center.x, y: 45)
            title.text = shareTitlesArray[index]
            title.backgroundColor = UIColor.clearColor()
            title.font = UIFont.systemFontOfSize(10)
            title.textAlignment = .Center
            contentView.addSubview(title)
        }
        
        UIView.animateWithDuration(0.2) {
            self.contentView.center = CGPoint(x: self.contentView.center.x, y: self.contentView.center.y-60)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapGestureAction() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.contentView.center = CGPoint(x: self.contentView.center.x, y: self.contentView.center.y+60)
            }) { (finished: Bool) -> Void in
                if (finished) {
                    self.removeFromSuperview()
                }
        }
    }
    
    func buttonAction(sender: UIButton) {
        switch sender.tag {
        case 0:
            ShareUtils.shareInstance().shareToFriendZone()
        case 1:
            ShareUtils.shareInstance().shareToWeChat()
        case 2:
            ShareUtils.shareInstance().shareToFaceBook()
        case 3:
            ShareUtils.shareInstance().shareToTweeter()
        default:
            break
        }
    }

}
