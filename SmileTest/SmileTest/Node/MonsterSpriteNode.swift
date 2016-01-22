//
//  MonsterSpriteNode.swift
//  SmileTest
//
//  Created by che on 16/1/5.
//  Copyright © 2016年 cheyongzi. All rights reserved.
//

import SpriteKit

class MonsterSpriteNode: SKSpriteNode {
    //用于Monster的帧动画
    var animationTexture: [SKTexture] = [] {
        didSet {
            let animationAction = SKAction.animateWithTextures(animationTexture, timePerFrame: 0.1)
            let repeatAction = SKAction.repeatActionForever(animationAction)
            self.runAction(repeatAction)
        }
    }

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
