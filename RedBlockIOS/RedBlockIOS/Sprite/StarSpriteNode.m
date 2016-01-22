//
//  StarSpriteNode.m
//  RedBlockIOS
//
//  Created by che on 15/5/7.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "StarSpriteNode.h"
#import "Utils.h"

@implementation StarSpriteNode

- (void)initPhysicsBodyWithPosition:(CGPoint)position {
    self.position = position;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(30, 30)];
    self.physicsBody.restitution = 0.0f;
    self.physicsBody.friction = 0.0f;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.categoryBitMask = starCategory;
    self.physicsBody.collisionBitMask = redBlockCategory;
    self.physicsBody.contactTestBitMask = redBlockCategory;
    self.name = @"Star";
}

@end
