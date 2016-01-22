//
//  MainMenuScene.swift
//  LinkAll
//
//  Created by che on 15/11/6.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene,MainMenuNodeTouchDelegate,VoiceNodeTouchDelegate {
    
    var voiceNode: VoiceSpriteNode!
    
    var shareButton: SKSpriteNode!
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        let voiceState = NSUserDefaults.standardUserDefaults().integerForKey("VoiceState")
        
        let backgroundImg = SKSpriteNode(imageNamed: "background.jpg")
        backgroundImg.position = (self.view?.center)!
        backgroundImg.zPosition = -100
        addChild(backgroundImg)
        
        let headerImg = SKSpriteNode(imageNamed: "header.png")
        headerImg.position = CGPoint(x: (self.view?.center.x)!, y: size.height-80)
        headerImg.size = CGSize(width: 193, height: 35)
        addChild(headerImg)
        
        for index in 0..<menuNameArray.count {
            let menuSprite = MainMenuSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 200, height: 60))
            menuSprite.position = CGPoint(x: (self.view?.center.x)!, y: size.height-CGFloat(index*100)-180)
            menuSprite.mainMenuNodeTouchDelegate = self
            menuSprite.titleName = menuNameArray[index]
            menuSprite.menuIndex = index+1
            addChild(menuSprite)
        }
        
        voiceNode = VoiceSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 40, height: 40))
        voiceNode.position = CGPoint(x: 30, y: 30)
        voiceNode.voiceNodeTouchDelegate = self
        voiceNode.isSlient = voiceState == 1 ? true : false
        addChild(voiceNode)
        
        shareButton = SKSpriteNode.init(imageNamed: "share");
        shareButton.position = CGPoint(x: size.width-30, y: 30)
        shareButton.size = CGSize(width: 40, height: 40)
        shareButton.name = "ShareButton"
        addChild(shareButton);
    }
    
    func mainMenuNodeTouch(node: MainMenuSpriteNode) {
        let voiceState = NSUserDefaults.standardUserDefaults().integerForKey("VoiceState")
        if voiceState == 0 {
            self.runAction(SKAction.playSoundFileNamed("mainMenu", waitForCompletion: false))
        }
        self.performSelector("mainMenuAction:", withObject: node, afterDelay: 0.1);
    }
    func mainMenuAction(node: MainMenuSpriteNode) {
        let scene = MenuScene(size:size)
        scene.menuIndex = node.menuIndex
        self.view?.presentScene(scene)
    }
    
    func voiceNodeTouch(node: VoiceSpriteNode) {
        let voiceState = NSUserDefaults.standardUserDefaults().integerForKey("VoiceState")
        if voiceState == 1 {
            NSUserDefaults.standardUserDefaults().setInteger(0, forKey: "VoiceState")
        } else {
            NSUserDefaults.standardUserDefaults().setInteger(1, forKey: "VoiceState")
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        voiceNode.isSlient = voiceState == 1 ? false : true
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let point = touch.locationInNode(self);
            if shareButton.containsPoint(point) {
                shareButtonAction()
            }
        }
    }
    
    func shareButtonAction() {
        let shareView = ShareView(frame: (self.view?.bounds)!)
        self.view?.addSubview(shareView)
    }
}
