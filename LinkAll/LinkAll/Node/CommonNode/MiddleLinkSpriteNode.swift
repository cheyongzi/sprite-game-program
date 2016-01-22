//
//  MiddleLinkSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/10.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

//28,45,135
class MiddleLinkSpriteNode: CustomSpriteNode {
    //数组用于确定节点被多少条线连接
    var middleLinkedLineArray: [Int] = [] {
        didSet {
            
        }
    }
    
    override var isLinked: Bool {
        didSet {
            //当Node被连接之后修改标志位，同时更新Node样式
            if outCircleShapeNode != nil {
                if isLinked {
                    outCircleShapeNode.fillColor = SKColor.colorWithRed(81, green: 110, blue: 255)
                } else {
                    outCircleShapeNode.fillColor = SKColor.colorWithRed(28, green: 45, blue: 135)
                }
            }
        }
    }
    
    var outCircleShapeNode: SKShapeNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        outCircleShapeNode = SKShapeNode(circleOfRadius: size.width/2)
        outCircleShapeNode.strokeColor = SKColor.colorWithRed(180, green: 178, blue: 214)
        outCircleShapeNode.lineWidth = 2
        outCircleShapeNode.fillColor = SKColor.colorWithRed(28, green: 45, blue: 135)
        addChild(outCircleShapeNode)
        
        let innerCircleShapeNode = SKShapeNode(circleOfRadius: 4)
        innerCircleShapeNode.lineWidth = 0
        innerCircleShapeNode.fillColor = SKColor.colorWithRed(180, green: 178, blue: 214)
        addChild(innerCircleShapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
