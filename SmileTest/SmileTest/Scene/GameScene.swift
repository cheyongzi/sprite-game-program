//
//  GameScene.swift
//  SmileTest
//
//  Created by che on 16/1/5.
//  Copyright (c) 2016年 cheyongzi. All rights reserved.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8);
        self.physicsWorld.contactDelegate = self;
        
        let edgeBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        edgeBody.friction = 0
        self.physicsBody = edgeBody
        
        let ballSpriteNode = BallSpriteNode(texture: nil, color: SKColor.blueColor(), size: CGSize(width: 40, height: 40))
        ballSpriteNode.position = CGPoint(x: 200, y: 200)
        addChild(ballSpriteNode);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
    }
}
