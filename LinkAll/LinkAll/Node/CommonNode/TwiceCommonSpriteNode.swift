//
//  TwiceCommonSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/12.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class TwiceCommonSpriteNode: CommonSpriteNode {
    
    var secondLinkedLineNode: LinkedLineSpriteNode?
    
    var isTouchOnceTime: Bool = false {
        didSet {
            if isTouchOnceTime {
                let fadeOutAction = SKAction.fadeOutWithDuration(0.3);
                let scaleAction = SKAction.scaleTo(1.5, duration: 0.3);
                let groupAction = SKAction.group([fadeOutAction, scaleAction])
                let scaleSAction = SKAction.scaleTo(1, duration: 0);
                let sequence = SKAction.sequence([groupAction,scaleSAction])
                secondOutterCircleNode.runAction(sequence)
            } else {
                secondOutterCircleNode.runAction(SKAction.fadeInWithDuration(0.2))
            }
            
            if isRelationship {
                if isTouchOnceTime {
                    relationshipLine?.isActivityRelationship = true
                } else {
                    relationshipLine?.isActivityRelationship = false
                }
            }
        }
    }
    
    override var isLinked: Bool {
        didSet {
            //当Node被连接之后修改标志位，同时更新Node样式
            if isLinked {
                let fadeOutAction = SKAction.fadeOutWithDuration(0.3);
                let scaleAction = SKAction.scaleTo(1.5, duration: 0.3);
                let groupAction = SKAction.group([fadeOutAction, scaleAction])
                let scaleSAction = SKAction.scaleTo(1, duration: 0);
                let sequence = SKAction.sequence([groupAction,scaleSAction])
                outterCircleNode.runAction(sequence)
            } else {
                outterCircleNode.runAction(SKAction.fadeInWithDuration(0.2))
            }
        }
    }
    
    var secondOutterCircleNode: CircleSpriteNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.secondOutterCircleNode = CircleSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: size.width+24, height: size.height+24))
        self.secondOutterCircleNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(self.secondOutterCircleNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
