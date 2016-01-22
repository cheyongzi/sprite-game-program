//
//  DirectionSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/13.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class DirectionSpriteNode: SKSpriteNode {

    var directions: [Directions] = [] {
        didSet {
            self.createShapePath()
        }
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    func createShapePath() {
        for index in 0..<directions.count-1 {
            let path = CGPathCreateMutable()
            let startDirection = directions[index]
            let startAngle = M_PI_4 * Double(startDirection.rawValue) + M_PI/20
            let endDirection = directions[index+1]
            var angleDelta = 0.0
            if index == directions.count-2 {
                angleDelta = M_PI_4 * fabs(Double(8 - startDirection.rawValue + endDirection.rawValue)) - M_PI/10
            } else {
                angleDelta = M_PI_4 * fabs(Double(endDirection.rawValue-startDirection.rawValue)) - M_PI/10
            }
            CGPathAddRelativeArc(path, nil, 0, 0, size.width/2+12, CGFloat(startAngle), CGFloat(angleDelta))
            self.createShapeNode(path)
        }
    }
    
    func createShapeNode(path: CGMutablePath) {
        let redOutterCircleNode = SKShapeNode(path: path)
        redOutterCircleNode.lineWidth = 5
        redOutterCircleNode.strokeColor = SKColor.redColor()
        addChild(redOutterCircleNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
