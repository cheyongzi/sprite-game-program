//
//  InformationSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/20.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class InformationSpriteNode: SKSpriteNode {

    var informationLabel: SKLabelNode!
    
    var secondLabel: SKLabelNode?
    
    var arrowSpriteNode: ArrowSpriteNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        informationLabel = SKLabelNode.init(fontNamed: "Iceland-Regular")
        informationLabel.fontColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        informationLabel.fontSize = 20
        informationLabel.verticalAlignmentMode = .Bottom
        addChild(informationLabel)
        
        secondLabel = SKLabelNode.init(fontNamed: "Iceland-Regular")
        secondLabel!.fontColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        secondLabel!.fontSize = 20
        secondLabel!.verticalAlignmentMode = .Top
        addChild(secondLabel!)
        
        arrowSpriteNode = ArrowSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 60, height: 20))
        arrowSpriteNode.position = CGPoint(x: 0, y: frame.origin.y)
        addChild(arrowSpriteNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
