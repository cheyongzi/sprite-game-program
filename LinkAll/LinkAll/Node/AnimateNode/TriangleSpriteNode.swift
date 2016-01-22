//
//  TriangleSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/10/29.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

enum AnimateDirection: Int {
    case AnimateClockwise = 1
    case AnimateAntiClockwise = -1
}

class TriangleSpriteNode: SKSpriteNode {
    
    var isFillColor: Bool = true {
        didSet {
            if !isFillColor {
                triangleShape?.fillColor = SKColor.clearColor()
            }
        }
    }
    
    var direction: AnimateDirection = .AnimateClockwise {
        didSet {
            animateTriangle()
        }
    }
    
    var triangleShape: SKShapeNode!

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let pointsArr = [CGPoint(x: -size.width/2, y: -size.height/2),CGPoint(x: 0, y: size.height/2),CGPoint(x: size.width/2, y: -size.height/2),CGPoint(x: -size.width/2, y: -size.height/2)]
        let points = UnSafePointer.trianglePoints(pointsArr)
        
        triangleShape = SKShapeNode(points: points, count: pointsArr.count)
        triangleShape.position = CGPoint(x: 0, y: 0)
        triangleShape.fillColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        triangleShape.strokeColor = SKColor.colorWithRed(81, green: 110, blue: 255)
        triangleShape.lineWidth = 2
        self.addChild(triangleShape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func animateTriangle() {
        let action = SKAction.rotateByAngle(CGFloat(Double(direction.rawValue) * 2 * M_PI), duration: 1.8)
        let repeateAction = SKAction.repeatActionForever(action)
        self.runAction(repeateAction)
    }
}
