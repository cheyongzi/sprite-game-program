//
//  CustomSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/10/29.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class CustomSpriteNode: SKSpriteNode {
    
    var nodeTouchDelegate: NodeTouchDelegate?
    
    var isLinked: Bool = false
    
    var isFirstStarted: Bool = false
    //标志该Node是否与其他Node有联系
    var isRelationship: Bool = false
    
    var linkedLine: LinkedLineSpriteNode?
    
    var relationshipLine: RelationshipSpriteNode?
    
    var userEnable: Bool = true
    
    var circleDirectionNode: DirectionSpriteNode?
    
    var isCircleDirectionNode: Bool = false {
        didSet {
            circleDirectionNode?.zPosition = 3
            self.addChild(circleDirectionNode!)
        }
    }
    
    var bridgeNode: BridgeSpriteNode?
    
    var isBridgeNode: Bool = false {
        didSet {
            bridgeNode?.zPosition = 4
            self.addChild(bridgeNode!)
        }
    }
    
    var redNode: RedColorSpriteNode?
    var isRedSpriteNode: Bool = false {
        didSet {
            redNode?.zPosition = 0
            self.addChild(redNode!)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        nodeTouchDelegate?.nodeTouch(self)
    }
}
