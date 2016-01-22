//
//  CommonSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/10/29.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class CommonSpriteNode: CustomSpriteNode {
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
            
            if isRelationship {
                if isLinked {
                    relationshipLine?.isActivityRelationship = true
                } else {
                    relationshipLine?.isActivityRelationship = false
                }
            }
        }
    }
    
    override var userEnable: Bool {
        didSet {
            if innerCircleNode != nil {
                if userEnable {
                    innerCircleNode.fillColor = SKColor.colorWithRed(81, green: 110, blue: 255)
                } else {
                    innerCircleNode.fillColor = SKColor.colorWithRed(136, green: 136, blue: 136)
                }
                self.userInteractionEnabled = userEnable
            }
            
        }
    }
    
    var outterCircleNode: CircleSpriteNode!
    var innerCircleNode: SKShapeNode!

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.userInteractionEnabled = true;
        
        self.outterCircleNode = CircleSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: size.width+12, height: size.height+12))
        self.outterCircleNode.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.outterCircleNode.zPosition = 1
        self.addChild(self.outterCircleNode)
        
        innerCircleNode = SKShapeNode(circleOfRadius: size.width/2)
        innerCircleNode!.fillColor = SKColor.colorWithRed(81, green: 110, blue: 255)
        innerCircleNode!.strokeColor = SKColor.colorWithRed(180, green: 178, blue: 214)
        innerCircleNode!.lineWidth = 3
        innerCircleNode.zPosition = 2
        self.addChild(innerCircleNode!)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
