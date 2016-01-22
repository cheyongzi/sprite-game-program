//
//  MenuScene.swift
//  LinkAll
//
//  Created by che on 15/11/6.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene,MenuNodeTouchDelegate,BackOrNextNodeTouchDelegate {
    
    var menuIndex: Int!
    
    var titleLabel: SKLabelNode!
    
    let voiceState = NSUserDefaults.standardUserDefaults().integerForKey("VoiceState")
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        let sceneSuccessGameIndex = NSUserDefaults.standardUserDefaults().integerForKey("\(menuIndex)")
        
        let backgroundImg = SKSpriteNode(imageNamed: "background.jpg")
        backgroundImg.position = (self.view?.center)!
        backgroundImg.zPosition = -100
        addChild(backgroundImg)
        
        let length = (view.frame.width - 240)/5
        let width = 60
        
        for index in 0..<20 {
            let menuSpriteNode = MenuSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: width, height: width))
            let pointX = CGFloat(index%4+1)*length+CGFloat(width/2) + CGFloat((index%4)*width)
            let value = index/4 + 1
            let height1 = CGFloat(value) * length
            let height2 = CGFloat(value * width)
            let pointY = view.frame.height - height1 - height2 - 50
            menuSpriteNode.position = CGPoint(x: pointX, y: pointY)
            menuSpriteNode.titleString = "\(index+1)"
            menuSpriteNode.menuNodeTouchDelegate = self
            addChild(menuSpriteNode)
            if index > sceneSuccessGameIndex {
                menuSpriteNode.notCanTouch = true
            }
        }
        
        titleLabel = SKLabelNode.init(fontNamed: "Iceland-Regular")
        titleLabel.position = CGPoint(x: view.center.x, y: view.frame.height-50)
        titleLabel.fontColor = SKColor.colorWithRed(179, green: 35, blue: 40)
        titleLabel.fontSize = 50
        titleLabel.verticalAlignmentMode = .Center
        titleLabel.text = menuNameArray[menuIndex-1]
        addChild(titleLabel)
        
        let backButtonNode = BackOrNextSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 60, height: 60))
        backButtonNode.zRotation = CGFloat(M_PI)
        if size.height == 480 {
            backButtonNode.position = CGPoint(x: length+30, y: size.height-40)
        } else {
            backButtonNode.position = CGPoint(x: length+30, y: 60)
        }
        backButtonNode.backOrNextNodeTouchDelegate = self
        addChild(backButtonNode)
    }
    
    //MARK: - BackOrNextNodeTouchDelegate
    func backOrNextNodeTouch(node: BackOrNextSpriteNode) {
        if voiceState == 0 {
            self.runAction(SKAction.playSoundFileNamed("menu", waitForCompletion: false))
        }
        self.performSelector("backNodeAction", withObject: nil, afterDelay: 0.1)
    }
    func backNodeAction() {
        let scene = MainMenuScene(size:self.view!.frame.size)
        self.view?.presentScene(scene)
    }
    
    func menuNodeTouch(node: MenuSpriteNode) {
        if voiceState == 0 {
            self.runAction(SKAction.playSoundFileNamed("menu", waitForCompletion: false))
        }
        self.performSelector("menuNodeAction:", withObject: node, afterDelay: 0.1)
    }
    func menuNodeAction(node:MenuSpriteNode) {
        let scene = GameScene(size:self.view!.frame.size)
        scene.menuIndex = menuIndex
        scene.currentGameIndex = (node.titleString as NSString).integerValue
        self.view?.presentScene(scene)
    }
}
