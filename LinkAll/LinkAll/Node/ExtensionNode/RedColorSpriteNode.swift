//
//  RedColorSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/12/18.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class RedColorSpriteNode: SKSpriteNode {

    var shapeNode: SKShapeNode!
    
    var redNodeType: Double = 0 {
        didSet {
            if redNodeType == 1 {
                shapeNode.strokeColor = SKColor.colorWithRed(0, green: 0, blue: 255)
                shapeNode.fillColor = SKColor.colorWithRed(0, green: 0, blue: 255)
            }
        }
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init(texture: SKTexture?, color: UIColor, size: CGSize, isSquare: Bool) {
        self.init(texture: texture, color: color, size: size)
        
        if isSquare {
            shapeNode = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRect(x: 0, y: 0, width: size.width+12, height: size.height+12), 6, 6, nil), centered: true)
        } else {
            shapeNode = SKShapeNode(circleOfRadius: size.width/2+6)
        }
        shapeNode.strokeColor = SKColor.colorWithRed(146, green: 44, blue: 61)
        shapeNode.fillColor = SKColor.colorWithRed(146, green: 44, blue: 61)
        self.addChild(shapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
