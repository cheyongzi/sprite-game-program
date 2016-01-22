//
//  BridgeSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/12/14.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class BridgeLineSpriteNode: SKSpriteNode {
    
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
            pointsArr = [CGPoint(x: -size.width/2, y: 4),CGPoint(x: -size.width/2+4, y: 0),CGPoint(x: size.width/2-4, y: 0),CGPoint(x: size.width/2, y: 4)]
        } else {
            pointsArr = [CGPoint(x: -size.width/2, y: -4),CGPoint(x: -size.width/2+4, y: 0),CGPoint(x: size.width/2-4, y: 0),CGPoint(x: size.width/2, y: -4)]
        }
        
        let points = UnSafePointer.trianglePoints(pointsArr)
        
        shapeNode = SKShapeNode(points: points, count: pointsArr.count)
        shapeNode.strokeColor = SKColor.colorWithRed(129, green: 132, blue: 151)
        shapeNode.lineWidth = 2
        self.addChild(shapeNode)
    }
}

class BridgeSpriteNode: SKSpriteNode {
    
    var bridgeDirection: FourDirection = FourDirection.Landscape {
        didSet {
            self.zRotation = CGFloat(M_PI_4 * Double(bridgeDirection.rawValue))
        }
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let upLineBlockNode = BridgeLineSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: size.width, height: 1), upPosition: true);
        upLineBlockNode.position = CGPoint(x: 0, y: 5)
        self.addChild(upLineBlockNode);
        
        let downLineBlockNode = BridgeLineSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: size.width, height: 1), upPosition: false);
        downLineBlockNode.position = CGPoint(x: 0, y: -5)
        self.addChild(downLineBlockNode);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
