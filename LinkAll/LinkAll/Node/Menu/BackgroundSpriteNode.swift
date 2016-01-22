//
//  BackgroundSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/6.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class BackgroundSpriteNode: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        let imgSpriteNode = SKSpriteNode(imageNamed: "back.jpg")
        imgSpriteNode.position = CGPoint(x: size.width/2, y: size.height/2)
        imgSpriteNode.size = size
        imgSpriteNode.zPosition = -100
        addChild(imgSpriteNode)
        
        let shapeNode = SKShapeNode(rectOfSize: size)
        shapeNode.position = CGPoint(x: size.width/2, y: size.height/2)
        shapeNode.strokeColor = SKColor.whiteColor()
        shapeNode.lineWidth = 2
        addChild(shapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
