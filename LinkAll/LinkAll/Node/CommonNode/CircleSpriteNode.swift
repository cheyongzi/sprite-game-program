//
//  CircleSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/10/29.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit
/*
* 
*/
class CircleSpriteNode: SKSpriteNode {
    
    var shapeNode: SKShapeNode!

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
        
        shapeNode = SKShapeNode(circleOfRadius: size.width/2)
        shapeNode.strokeColor = SKColor.colorWithRed(129, green: 132, blue: 151)
        shapeNode.lineWidth = 3
        self.addChild(shapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
