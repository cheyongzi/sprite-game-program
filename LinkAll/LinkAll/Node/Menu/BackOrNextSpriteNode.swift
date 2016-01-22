//
//  BackOrNextSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/6.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class BackOrNextSpriteNode: SKSpriteNode {

    var backOrNextNodeTouchDelegate: BackOrNextNodeTouchDelegate?
    
    var backOrNextType: Int = 0
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.userInteractionEnabled = true;
        
        let circleShapeNode = SKShapeNode(circleOfRadius: size.width/2)
        circleShapeNode.fillColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        circleShapeNode.lineWidth = 1
        circleShapeNode.strokeColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        addChild(circleShapeNode)
        
        let pointsArr = [CGPoint(x: size.width/2+5, y: size.height-15),CGPoint(x: size.width-10, y: size.height/2),CGPoint(x: size.width/2+5, y: 15)]
        let points = UnSafePointer.trianglePoints(pointsArr)
        let lineNode = SKShapeNode(points: points, count: pointsArr.count)
        lineNode.position = self.frame.origin
        lineNode.lineWidth = 8
        lineNode.lineJoin = .Round
        lineNode.lineCap = .Round
        lineNode.strokeColor = SKColor.colorWithRed(37, green: 62, blue: 63)
        addChild(lineNode)
        
        let otherPointsArr = [CGPoint(x: 10, y: size.height/2),CGPoint(x: size.width-10, y: size.height/2)]
        let otherPoints = UnSafePointer.trianglePoints(otherPointsArr)
        let otherLineNode = SKShapeNode(points: otherPoints, count: otherPointsArr.count)
        otherLineNode.position = self.frame.origin
        otherLineNode.lineWidth = 8
        otherLineNode.lineJoin = .Round
        otherLineNode.lineCap = .Round
        otherLineNode.strokeColor = SKColor.colorWithRed(37, green: 62, blue: 63)
        addChild(otherLineNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        backOrNextNodeTouchDelegate?.backOrNextNodeTouch(self)
    }
}
