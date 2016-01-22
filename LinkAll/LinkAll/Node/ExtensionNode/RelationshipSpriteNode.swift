//
//  RelationshipSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/11.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class RelationshipSpriteNode: SKSpriteNode {
    
    var unableTouchNode: CustomSpriteNode!
    
    var isActivityRelationship: Bool = false {
        didSet {
            if isActivityRelationship {
                unableTouchNode.userEnable = true
                self.shapeNode.strokeColor = SKColor.colorWithRed(81, green: 110, blue: 255)
            } else {
                unableTouchNode.userEnable = false
                self.shapeNode.strokeColor = SKColor.colorWithRed(129, green: 132, blue: 151)
            }
        }
    }
    
    var shapeNode: SKShapeNode!

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        let pointsArr = [CGPoint(x: 0, y: size.height),CGPoint(x: 5, y: 0),CGPoint(x: size.width-5, y: 0),CGPoint(x: size.width, y: size.height)]
        let points = UnSafePointer.trianglePoints(pointsArr)
        
        self.shapeNode = SKShapeNode(points: points, count: pointsArr.count)
        self.shapeNode.lineWidth = 2
        self.shapeNode.position = self.frame.origin
        self.shapeNode.strokeColor = SKColor.colorWithRed(129, green: 132, blue: 151)
        addChild(self.shapeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
