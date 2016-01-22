//
//  KeySpriteNode.m
//  RedBlockIOS
//
//  Created by che on 15/5/12.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "KeySpriteNode.h"
#import "Utils.h"

@implementation KeySpriteNode

- (void)initPhysicsBodyWithPosition:(CGPoint)position {
    self.position = position;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(45, 22)];
    self.physicsBody.restitution = 0.0f;
    self.physicsBody.friction = 0.0f;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.categoryBitMask = keyCategory;
    self.physicsBody.collisionBitMask = redBlockCategory;
    self.physicsBody.contactTestBitMask = redBlockCategory;
}

@end
