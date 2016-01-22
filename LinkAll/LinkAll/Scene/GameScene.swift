//
//  GameScene.swift
//  LinkAll
//
//  Created by che on 15/10/29.
//  Copyright (c) 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class GameScene: CustomGameScene,BackOrNextNodeTouchDelegate,RefreshNodeTouchDelegate {
    
    var mapName: String!
    
    var menuIndex: Int!
    var currentGameIndex: Int! {
        didSet {
            mapName = "\(menuIndex)_Map\(currentGameIndex)"
        }
    }
    
    var nextButtonNode: BackOrNextSpriteNode?
    
    var backButtonNode: BackOrNextSpriteNode!
    
    var isStartNewGame: Bool = false
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        super.didMoveToView(view)
        if voiceState == 0 {
            self.runAction(SKAction.playSoundFileNamed("start", waitForCompletion: false))
        }
        
        if let path = NSBundle.mainBundle().pathForResource(mapName, ofType: "json") {
            let pathUrl = NSURL(fileURLWithPath: path)
            if let data = NSData(contentsOfURL: pathUrl) {
                let (jsonValue, error) = JSON.parse(data)
                if (error == nil) {
                    SceneCreate.createNodesWithJson(jsonValue, scene: self)
                }
            }
        }
        
        let titleSpriteNode = SKLabelNode.init(fontNamed: "Iceland-Regular")
        titleSpriteNode.fontColor = SKColor.colorWithRed(161, green: 252, blue: 154)
        titleSpriteNode.fontSize = 40
        titleSpriteNode.position = CGPoint(x: size.width/2, y: size.height-30)
        titleSpriteNode.text = "\(menuNameArray[menuIndex-1])" + "-" + "\(currentGameIndex)"
        titleSpriteNode.verticalAlignmentMode = .Center
        addChild(titleSpriteNode)
        
        backButtonNode = BackOrNextSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 60, height: 60))
        backButtonNode.zRotation = CGFloat(M_PI)
        backButtonNode.position = CGPoint(x: 40, y: size.height - 40)
        backButtonNode.backOrNextNodeTouchDelegate = self
        backButtonNode.backOrNextType = 1
        addChild(backButtonNode)
        
        let refreshButton = RefreshSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 60, height: 60))
        refreshButton.position = CGPoint(x: 40, y: 40)
        refreshButton.refreshNodeTouchDelegate = self
        addChild(refreshButton)
        
        self.addInformationNode()
    }
    
    func addInformationNode() {
        switch menuIndex {
        case 1:
                if currentGameIndex == 1 {
                    let information = InformationSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 100, height: 40))
                    information.position = CGPoint(x: 220, y: 305)
                    information.informationLabel.text = NSLocalizedString("scene1Tip1_1", comment: "")
                    information.secondLabel?.text = NSLocalizedString("scene1Tip1_2", comment: "")
                    information.arrowSpriteNode.zRotation = CGFloat(-M_PI/4)
                    information.zPosition = -10
                    backgroundNode.addChild(information)
                }else if currentGameIndex == 2 {
                    let information = InformationSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 100, height: 40))
                    information.position = CGPoint(x: 150, y: 350)
                    information.informationLabel.text = NSLocalizedString("scene1Tip2", comment: "")
                    information.informationLabel.verticalAlignmentMode = .Top
                    information.arrowSpriteNode.zRotation = CGFloat(-M_PI_2)
                    information.zPosition = -10
                    backgroundNode.addChild(information)
                }else if currentGameIndex == 5 {
                    let information = InformationSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 100, height: 40))
                    information.position = CGPoint(x: 140, y: 390)
                    information.informationLabel.text = NSLocalizedString("scene1Tip3", comment: "")
                    information.informationLabel.verticalAlignmentMode = .Top
                    information.arrowSpriteNode.zRotation = CGFloat(-M_PI_2)
                    information.zPosition = -10
                    backgroundNode.addChild(information)
                }
        case 2:
            if currentGameIndex == 1 {
                let information = InformationSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 100, height: 40))
                information.position = CGPoint(x: 220, y: 420)
                information.informationLabel.text = NSLocalizedString("scene2Tip1_1", comment: "")
                information.secondLabel?.text = NSLocalizedString("scene2Tip1_2", comment: "")
                information.arrowSpriteNode.zRotation = CGFloat(-M_PI/4)
                information.zPosition = -10
                backgroundNode.addChild(information)
            } else if currentGameIndex == 6 {
                let information = InformationSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 100, height: 40))
                information.position = CGPoint(x: 220, y: 420)
                information.informationLabel.text = NSLocalizedString("scene2Tip2_1", comment: "")
                information.secondLabel?.text = NSLocalizedString("scene2Tip2_2", comment: "")
                information.arrowSpriteNode.zRotation = CGFloat(-5*M_PI/6)
                information.zPosition = -10
                backgroundNode.addChild(information)
            }
        case 3:
            if currentGameIndex == 1 {
                let information = InformationSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 100, height: 40))
                information.position = CGPoint(x: 220, y: 420)
                information.informationLabel.text = NSLocalizedString("scene3Tip1_1", comment: "")
                information.secondLabel?.text = NSLocalizedString("scene3Tip1_2", comment: "")
                information.arrowSpriteNode.zRotation = CGFloat(-5*M_PI/6)
                information.zPosition = -10
                backgroundNode.addChild(information)
            } else if currentGameIndex == 15 {
                let information = InformationSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 100, height: 40))
                information.position = CGPoint(x: 210, y: 390)
                information.informationLabel.text = NSLocalizedString("scene3Tip2_1", comment: "")
                information.secondLabel?.text = NSLocalizedString("scene3Tip2_2", comment: "")
                information.arrowSpriteNode.zRotation = CGFloat(-M_PI/2)
                information.zPosition = -10
                backgroundNode.addChild(information)
            }
        default:
            break
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if squareNode.linkedLine != nil && !isStartNewGame {
            UserData.saveUserData(currentGameIndex, sceneIndex: menuIndex)
            if voiceState == 0 {
                self.runAction(SKAction.playSoundFileNamed("success", waitForCompletion: false))
            }
            isStartNewGame = true
            if self.currentGameIndex < 20 {
                nextButtonNode = BackOrNextSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 60, height: 60))
                nextButtonNode?.position = CGPoint(x: -100, y: 40)
                nextButtonNode?.backOrNextNodeTouchDelegate = self
                nextButtonNode?.backOrNextType = 0
                addChild(nextButtonNode!)
                
                nextButtonNode?.runAction(SKAction.moveToX(size.width-50, duration: 0.3))
            }
        }
    }
    
    //MARK: - BackOrNextNodeTouchDelegate
    func backOrNextNodeTouch(node: BackOrNextSpriteNode) {
        if node.backOrNextType == 0 {
            if self.currentGameIndex < 20 {
                if voiceState == 0 {
                    self.runAction(SKAction.playSoundFileNamed("next", waitForCompletion: false))
                }
                self.performSelector("backOrNextAction:", withObject: node, afterDelay: 0.1)
            }
        } else {
            if voiceState == 0 {
                self.runAction(SKAction.playSoundFileNamed("mainMenu", waitForCompletion: false))
            }
            self.performSelector("backOrNextAction:", withObject: node, afterDelay: 0.1)
        }
    }
    func backOrNextAction(node: BackOrNextSpriteNode) {
        if node.backOrNextType == 0 {
            if self.currentGameIndex < 20 {
                let newGameScene = GameScene(size: size)
                newGameScene.menuIndex = self.menuIndex
                newGameScene.currentGameIndex = self.currentGameIndex+1
                self.view?.presentScene(newGameScene)
            }
        } else {
            let scene = MenuScene(size:size)
            scene.menuIndex = menuIndex
            self.view?.presentScene(scene)
        }
    }
    
    //MARK: - RefreshNodeTouchDelegate
    func refreshNodeTouch(node: RefreshSpriteNode) {
        let newGameScene = GameScene(size: size)
        newGameScene.menuIndex = self.menuIndex
        newGameScene.currentGameIndex = self.currentGameIndex
        self.view?.presentScene(newGameScene)
    }
}
