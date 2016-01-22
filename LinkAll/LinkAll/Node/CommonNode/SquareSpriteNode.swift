//
//  SquareSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/10/29.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class SquareSpriteNode: CustomSpriteNode {
    
    var outterShapeNode: SKShapeNode!
    
    override var isLinked: Bool{
        didSet {
            if isLinked {
                outterShapeNode.hidden = true
            } else {
                outterShapeNode.hidden = false
            }
        }
    }
//    
//    override var isRedSpriteNode: Bool {
//        didSet {
//            if isRedSpriteNode {
//                if outterShapeNode != nil {
//                    outterShapeNode.fillColor = SKColor.colorWithRed(146, green: 44, blue: 61)
//                }
//            }
//        }
//    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.userInteractionEnabled = true
        
        outterShapeNode = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRect(x: 0, y: 0, width: size.width+12, height: size.height+12), 6, 6, nil), centered: true)
        outterShapeNode.lineWidth = 3
        outterShapeNode.strokeColor = SKColor.colorWithRed(129, green: 132, blue: 151)
        outterShapeNode.zPosition = 1
        self.addChild(outterShapeNode)
        
        let squareNode = SKShapeNode(path: CGPathCreateWithRoundedRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), 4, 4, nil), centered: true)
        squareNode.fillColor = SKColor.colorWithRed(81, green: 110, blue: 255)
        squareNode.strokeColor = SKColor.colorWithRed(180, green: 178, blue: 214)
        squareNode.lineWidth = 3
        squareNode.zPosition = 2
        self.addChild(squareNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
