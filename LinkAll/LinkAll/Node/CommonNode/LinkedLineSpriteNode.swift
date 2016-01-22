//
//  LinkedLineSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/2.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class LinkedLineSpriteNode: SKSpriteNode {

    var shapeNode: SKShapeNode!
    
    var locked: Bool = false {
        didSet {
            if locked {
                shapeNode.fillColor = SKColor.colorWithRed(203, green: 0, blue: 123)
            }
        }
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.anchorPoint = CGPoint(x: 0, y: 0.5)
        
        shapeNode = SKShapeNode(rect: CGRect(origin: CGPoint(x: self.frame.origin.x, y: -5), size: CGSize(width: size.width, height: 10)))
        shapeNode.xScale = 0
        shapeNode.strokeColor = SKColor.colorWithRed(213, green: 210, blue: 252)
        shapeNode.lineWidth = 3
        shapeNode.fillColor = SKColor.colorWithRed(121, green: 183, blue: 205)
        shapeNode.antialiased = true
        self.addChild(shapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animateWithScale(scale: CGFloat, complete: () -> Void) {
        shapeNode.runAction(SKAction.scaleXTo(scale, duration: 0.3)){
            if scale == 0 {
                self.removeFromParent()
            }
            complete()
        }
    }
    
    var isLastLinkeLine: Bool = true {
        didSet {
            if !isLastLinkeLine {
                shapeNode.fillColor = SKColor.colorWithRed(81, green: 110, blue: 255)
            } else {
                shapeNode.fillColor = SKColor.colorWithRed(121, green: 183, blue: 205)
            }
        }
    }
}
