//
//  BallSpriteNode.swift
//  SmileTest
//
//  Created by che on 16/1/5.
//  Copyright © 2016年 cheyongzi. All rights reserved.
//

import SpriteKit

class BallSpriteNode: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size);
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: size.width/2)
        self.physicsBody?.friction = 1.0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.dynamic = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
