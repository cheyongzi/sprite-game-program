//
//  BlockSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/5.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class BlockSpriteNode: SKSpriteNode {
    
    var shapeNode: SKShapeNode!
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(texture: SKTexture?, color: UIColor, size: CGSize, rotation: CGFloat) {
        self.init(texture: texture, color: color, size: size)
        
        self.name = "Block"
        
        shapeNode = SKShapeNode(rect: CGRect(origin: CGPoint(x: self.frame.origin.x, y: -5), size: CGSize(width: size.width, height: 10)))
        shapeNode.strokeColor = SKColor.colorWithRed(255, green: 0, blue: 0)
        shapeNode.lineWidth = 4
        shapeNode.antialiased = true
        self.zRotation = rotation
        self.addChild(shapeNode)
    }
}
