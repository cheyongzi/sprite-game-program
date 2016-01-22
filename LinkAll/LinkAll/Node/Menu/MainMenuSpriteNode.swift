//
//  MainMenuSpriteNode.swift
//  LinkAll
//
//  Created by che on 15/11/6.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class MainMenuSpriteNode: SKSpriteNode {
    
    var mainMenuNodeTouchDelegate: MainMenuNodeTouchDelegate?
    
    var titleSpriteNode: SKLabelNode!
    
    var titleName: String? {
        didSet {
            titleSpriteNode.text = titleName
        }
    }
    var menuIndex: Int?

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.userInteractionEnabled = true
        
        let imgSpriteNode = SKSpriteNode(imageNamed: "menubutton.png")
        imgSpriteNode.size = size
        addChild(imgSpriteNode)
        
        titleSpriteNode = SKLabelNode.init(fontNamed: "Iceland-Regular")
        titleSpriteNode.fontColor = SKColor.colorWithRed(179, green: 35, blue: 40)
        titleSpriteNode.fontSize = 50
        titleSpriteNode.verticalAlignmentMode = .Center
        addChild(titleSpriteNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        mainMenuNodeTouchDelegate?.mainMenuNodeTouch(self)
    }
}
