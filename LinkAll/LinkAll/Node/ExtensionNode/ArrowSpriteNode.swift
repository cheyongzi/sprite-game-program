//
//  ArrowSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/20.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class ArrowSpriteNode: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        let pointsArray1 = [CGPoint(x: 0, y: 10),CGPoint(x: size.width-20, y: 10)]
        let unsafePoints1 = UnSafePointer.trianglePoints(pointsArray1)
        let lineNode = SKShapeNode(points: unsafePoints1, count: pointsArray1.count)
        lineNode.position = CGPoint(x: 0, y: 0)
        lineNode.strokeColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        lineNode.lineWidth = 10
        addChild(lineNode)
        
        let pointsArray = [CGPoint(x: 0, y: 0),CGPoint(x: 20, y: 10),CGPoint(x: 0, y: 20),CGPoint(x: 0, y: 0)]
        let unsafePoints = UnSafePointer.trianglePoints(pointsArray)
        let squareNode = SKShapeNode(points: unsafePoints, count: pointsArray.count)
        squareNode.strokeColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        squareNode.position = CGPointMake(size.width-20, 0)
        squareNode.lineWidth = 1
        squareNode.fillColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        addChild(squareNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
