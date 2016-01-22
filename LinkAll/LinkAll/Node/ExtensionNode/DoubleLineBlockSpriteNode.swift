//
//  DoubleLineBlockSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/12/14.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class LineBlockSpriteNode: SKSpriteNode {
    
    var shapeNode: SKShapeNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(texture: SKTexture?, color: UIColor, size: CGSize, upPosition: Bool) {
        self.init(texture: texture, color: color, size: size)
        var pointsArr: [CGPoint]
        if upPosition {
            pointsArr = [CGPoint(x: -size.width/2, y: -3),CGPoint(x: -size.width/2, y: 0),CGPoint(x: size.width/2, y: 0),CGPoint(x: size.width/2, y: -3)]
        } else {
            pointsArr = [CGPoint(x: -size.width/2, y: 3),CGPoint(x: -size.width/2, y: 0),CGPoint(x: size.width/2, y: 0),CGPoint(x: size.width/2, y: 3)]
        }
        
        let points = UnSafePointer.trianglePoints(pointsArr)
        
        shapeNode = SKShapeNode(points: points, count: pointsArr.count)
        shapeNode.strokeColor = SKColor.colorWithRed(255, green: 0, blue: 0)
        shapeNode.lineWidth = 3
        self.addChild(shapeNode)
    }
}

class DoubleLineBlockSpriteNode: SKSpriteNode {
    
    var direction: FourDirection = FourDirection.Landscape {
        didSet {
            self.zRotation = CGFloat((Double)(direction.rawValue) * M_PI_4)
        }
    }
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.name = "DoubleBlock"
        
        let upLineBlockNode = LineBlockSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: size.width, height: 1), upPosition: true);
        upLineBlockNode.position = CGPoint(x: 0, y: 10)
        self.addChild(upLineBlockNode);
        
        let downLineBlockNode = LineBlockSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: size.width, height: 1), upPosition: false);
        downLineBlockNode.position = CGPoint(x: 0, y: -10)
        self.addChild(downLineBlockNode);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
