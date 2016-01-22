//
//  LockMiddleSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/18.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class LockMiddleSpriteNode: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let outterShapeNode = SKShapeNode(rectOfSize: size, cornerRadius: 2)
        outterShapeNode.lineWidth = 1
        outterShapeNode.strokeColor = SKColor.colorWithRed(190, green: 171, blue: 208)
        addChild(outterShapeNode)
        
        let innerShapeNode = SKShapeNode(rectOfSize: CGSize(width: size.width-8, height: size.height-8),cornerRadius: 0)
        innerShapeNode.lineWidth = 1
        outterShapeNode.strokeColor = SKColor.colorWithRed(190, green: 171, blue: 208)
        addChild(innerShapeNode)
        
        let otherShapeNode = SKShapeNode(rectOfSize: CGSize(width: size.width-4, height: size.height-4), cornerRadius: 1)
        otherShapeNode.lineWidth = 3
        otherShapeNode.strokeColor = SKColor.colorWithRed(222, green: 22, blue: 79)
        addChild(otherShapeNode)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
