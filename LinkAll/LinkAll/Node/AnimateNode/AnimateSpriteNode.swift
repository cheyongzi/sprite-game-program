//
//  AnimateSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/10/29.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit
/*

*/
class AnimateSpriteNode: SKSpriteNode {
    
    var fillColorTriangleNode: TriangleSpriteNode!
    var noneColorTriangleNode: TriangleSpriteNode!
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        fillColorTriangleNode = TriangleSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: size.width, height: size.height))
        fillColorTriangleNode.position = CGPoint(x: 0, y: 0)
        fillColorTriangleNode.direction = AnimateDirection.AnimateClockwise
        self.addChild(fillColorTriangleNode)
        
        noneColorTriangleNode = TriangleSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: size.width+12, height: size.height+12))
        noneColorTriangleNode.position = CGPoint(x: 0, y: 3)
        noneColorTriangleNode.isFillColor = false
        noneColorTriangleNode.direction = AnimateDirection.AnimateAntiClockwise
        self.addChild(noneColorTriangleNode)
    }
    
    func actionMoveTo(position: CGPoint,duration: NSTimeInterval, complete: () -> Void) {
        let action = SKAction.moveTo(position, duration: duration)
        self.runAction(action) {
            complete()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
