//
//  MenuSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/9.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class MenuSpriteNode: SKSpriteNode {
    
    var titleString: String = "" {
        didSet {
            titleSpriteNode.text = titleString
        }
    }
    
    var notCanTouch: Bool = false {
        didSet {
            if notCanTouch {
                self.userInteractionEnabled = false
                titleSpriteNode.fontColor = SKColor.grayColor()
            }
        }
    }
    
    var titleSpriteNode: SKLabelNode!
    
    var menuNodeTouchDelegate: MenuNodeTouchDelegate?

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.userInteractionEnabled = true
        
        let shapeNode = SKShapeNode(rectOfSize: self.size)
        shapeNode.strokeColor = SKColor.colorWithRed(27, green: 71, blue: 60)
        shapeNode.lineWidth = 1
        addChild(shapeNode)
        
        titleSpriteNode = SKLabelNode.init(fontNamed: "Iceland-Regular")
        titleSpriteNode.fontColor = SKColor.colorWithRed(179, green: 35, blue: 40)
        titleSpriteNode.fontSize = 40
        titleSpriteNode.verticalAlignmentMode = .Center
        addChild(titleSpriteNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        menuNodeTouchDelegate?.menuNodeTouch(self)
    }
}
