//
//  RefreshSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/23.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class RefreshSpriteNode: SKSpriteNode {
    
    var refreshNodeTouchDelegate: RefreshNodeTouchDelegate?

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.userInteractionEnabled = true
        
        let upRefreshShpaePath = UIBezierPath(arcCenter: self.frame.origin, radius: size.width/2-4, startAngle: CGFloat(M_PI/4), endAngle: CGFloat(M_PI), clockwise: true)
        let upRefreshShapeNode = SKShapeNode(path: upRefreshShpaePath.CGPath)
        upRefreshShapeNode.lineWidth = 8
        upRefreshShapeNode.strokeColor = SKColor.colorWithRed(219, green: 219, blue: 219)
        upRefreshShapeNode.position = CGPoint(x: size.width/2, y: size.height/2)
        upRefreshShapeNode.antialiased = true
        addChild(upRefreshShapeNode)
        
        let downRefreshShpaePath = UIBezierPath(arcCenter: self.frame.origin, radius: size.width/2-4, startAngle: CGFloat(0), endAngle: CGFloat(-3*M_PI/4), clockwise: false)
        let downRefreshShpaeNode = SKShapeNode(path: downRefreshShpaePath.CGPath)
        downRefreshShpaeNode.lineWidth = 8
        downRefreshShpaeNode.strokeColor = SKColor.colorWithRed(219, green: 219, blue: 219)
        downRefreshShpaeNode.position = CGPoint(x: size.width/2, y: size.height/2)
        downRefreshShpaeNode.antialiased = true
        addChild(downRefreshShpaeNode)
        
        let upTriangleShapeArray = [CGPoint(x: 0, y: 0),CGPoint(x: 16, y: 0),CGPoint(x: 8, y: 13.8),CGPoint(x: 0, y: 0)]
        let upTriangleShapePath = UnSafePointer.trianglePoints(upTriangleShapeArray)
        let upTriangleShapeNode = SKShapeNode(points: upTriangleShapePath, count: upTriangleShapeArray.count)
        upTriangleShapeNode.strokeColor = SKColor.colorWithRed(219, green: 219, blue: 219)
        upTriangleShapeNode.fillColor = SKColor.colorWithRed(219, green: 219, blue: 219)
        upTriangleShapeNode.lineWidth = 1
        upTriangleShapeNode.antialiased = true
        upTriangleShapeNode.position = CGPoint(x: size.width/2-18, y: 13)
        addChild(upTriangleShapeNode)
        upTriangleShapeNode.zRotation = -CGFloat(M_PI/12)

        let downTriangleShapeNode = SKShapeNode(points: upTriangleShapePath, count: upTriangleShapeArray.count)
        downTriangleShapeNode.strokeColor = SKColor.colorWithRed(219, green: 219, blue: 219)
        downTriangleShapeNode.fillColor = SKColor.colorWithRed(219, green: 219, blue: 219)
        downTriangleShapeNode.lineWidth = 1
        downTriangleShapeNode.antialiased = true
        downTriangleShapeNode.position = CGPoint(x: -size.width/2+2, y: -9)
        addChild(downTriangleShapeNode)
        downTriangleShapeNode.zRotation = CGFloat(-5*M_PI/12)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        refreshNodeTouchDelegate?.refreshNodeTouch(self)
    }
}
