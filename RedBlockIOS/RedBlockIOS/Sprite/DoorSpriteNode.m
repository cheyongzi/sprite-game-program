//
//  DoorSpriteNode.m
//  RedBlockIOS
//
//  Created by che on 15/5/12.
//  Copyright (c) 2015年 cyzcj. All rights reserved.
//

#import "DoorSpriteNode.h"

@implementation DoorSpriteNode

- (void)initPhysicsBodyWithPosition:(CGPoint)position {
    self.position = position;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.restitution = 0.0f;
    self.physicsBody.friction = 0.0f;
    self.physicsBody.allowsRotation = NO;
    self.physicsBody.usesPreciseCollisionDetection = YES;
    self.physicsBody.dynamic = NO;
    self.name = @"Door";
}

@end
