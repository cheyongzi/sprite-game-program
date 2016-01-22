//
//  VoiceSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/23.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class VoiceSpriteNode: SKSpriteNode {
    
    var isSlient: Bool = false {
        didSet {
            if isSlient {
                noneVoiceLine.hidden = false
            } else {
                noneVoiceLine.hidden = true
            }
        }
    }

    var noneVoiceLine: SKShapeNode!
    
    var voiceNodeTouchDelegate: VoiceNodeTouchDelegate?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.userInteractionEnabled = true
        
        let circleShapeNode = SKShapeNode(circleOfRadius: size.width/2-2)
        circleShapeNode.strokeColor = SKColor.colorWithRed(51, green: 51, blue: 51)
        circleShapeNode.lineWidth = 3
        circleShapeNode.fillColor = SKColor.colorWithRed(77, green: 92, blue: 101)
        addChild(circleShapeNode)
        
        let pointArray = [CGPoint(x: 0, y: -3),CGPoint(x: 0, y: 3),CGPoint(x: 3, y: 3),CGPoint(x: 10, y: 6),CGPoint(x: 10, y: -6),CGPoint(x: 3, y: -3),CGPoint(x: 0, y: -3)]
        let unsafePoint = UnSafePointer.trianglePoints(pointArray)
        let shapeNode = SKShapeNode(points: unsafePoint, count: pointArray.count)
        shapeNode.fillColor = SKColor.colorWithRed(51, green: 51, blue: 51)
        shapeNode.strokeColor = SKColor.colorWithRed(51, green: 51, blue: 51)
        shapeNode.lineWidth = 1
        shapeNode.position = CGPoint(x: -10, y: 0)
        addChild(shapeNode)
        
        let path1 = UIBezierPath(arcCenter: self.frame.origin, radius: 6, startAngle: CGFloat(-M_PI_4), endAngle: CGFloat(M_PI_4), clockwise: true)
        let shapeNode1 = SKShapeNode(path: path1.CGPath)
        shapeNode1.lineWidth = 2
        shapeNode1.strokeColor = SKColor.colorWithRed(51, green: 51, blue: 51)
        shapeNode1.position = CGPoint(x: size.width/2-2, y: size.height/2)
        addChild(shapeNode1)
        
        let path2 = UIBezierPath(arcCenter: self.frame.origin, radius: 10, startAngle: CGFloat(-M_PI_4), endAngle: CGFloat(M_PI_4), clockwise: true)
        let shapeNode2 = SKShapeNode(path: path2.CGPath)
        shapeNode2.lineWidth = 2
        shapeNode2.strokeColor = SKColor.colorWithRed(51, green: 51, blue: 51)
        shapeNode2.position = CGPoint(x: size.width/2-2, y: size.height/2)
        addChild(shapeNode2)
        
        let nonePointArray = [CGPoint(x: -8, y: 8),CGPoint(x: 8, y: -8)]
        let unsafeNonePointArray = UnSafePointer.trianglePoints(nonePointArray)
        noneVoiceLine = SKShapeNode(points: unsafeNonePointArray, count: nonePointArray.count)
        noneVoiceLine.lineWidth = 2
        noneVoiceLine.strokeColor = SKColor.colorWithRed(51, green: 51, blue: 51)
        addChild(noneVoiceLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        voiceNodeTouchDelegate?.voiceNodeTouch(self)
    }
}
