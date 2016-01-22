//
//  SceneCreate.swift
//  LinkAll
//
//  Created by che on 15/11/5.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

struct SceneCreate {
    var scene: SKScene
    static func createNodesWithJson(json: JSValue?, scene: CustomGameScene) {
        if let resultJson = json {
            if let datas = resultJson["nodes"].array {
                for data in datas {
                    if let nodeType = data["nodeType"].number {
                        switch nodeType {
                        case 1:
                            createCommonNode(data, scene: scene)
                        case 2:
                            createSquareNode(data, scene: scene)
                        case 3:
                            createAnimateNode(data, scene: scene)
                        case 4:
                            createBlockNode(data, scene: scene)
                        case 5:
                            createMiddleLinkNode(data, scene: scene)
                        case 6:
                            createRelationshipNode(data, scene: scene)
                        case 7:
                            createTwiceCommonNode(data, scene: scene)
                        case 8:
                            createLockMiddleNode(data, scene:scene)
                        case 9:
                            createDoubleLineBlockNode(data, scene:scene)
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
    
    static func createCommonNode(data: JSValue, scene: CustomGameScene) {
        let commonNode = CommonSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
        commonNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        commonNode.nodeTouchDelegate = scene
        commonNode.zPosition = 1
        if let _ = data["isStartNode"].bool {
            scene.currentNode = commonNode
            scene.connectedPoints.append(commonNode.position)
            commonNode.isLinked = true
        }
        if let nodeName = data["nodeName"].string {
            commonNode.name = nodeName;
        }
        if let _ = data["relationship"].bool {
            commonNode.isRelationship = true
        }
        //Json数据中Direction表示哪些方向可以进行连接，0-7，按逆时针右➡️左 8个方向
        if let jsonDirection = data["circleDirections"].array {
            var directionArray: [Directions] = [];
            for value in jsonDirection {
                directionArray.append(Directions(rawValue: Int(value.number!)))
            }
            
            directionArray.sortInPlace { (direction1: Directions, direction2: Directions) -> Bool in
                return direction1.rawValue < direction2.rawValue
            }
            directionArray.append(directionArray[0])
            
            commonNode.circleDirectionNode = DirectionSpriteNode.init(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
            commonNode.circleDirectionNode!.directions = directionArray
            commonNode.isCircleDirectionNode = true
        }
        //判断是否存在BridgeNode
        if let directionValue = data["bridgeDirection"].number {
            let direction = FourDirection(rawValue: Int(directionValue))
            commonNode.bridgeNode = BridgeSpriteNode.init(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!*2.0, height: data["nodeH"].number!))
            commonNode.bridgeNode!.bridgeDirection = direction
            commonNode.isBridgeNode = true
        }
        
        if let _ = data["isRedSpriteNode"].bool {
            commonNode.redNode = RedColorSpriteNode.init(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!), isSquare: false)
            if let redNodeType = data["redSpriteType"].number {
                commonNode.redNode?.redNodeType = redNodeType
            }
            commonNode.isRedSpriteNode = true
        }
        
        scene.backgroundNode.addChild(commonNode)
    }
    
    static func createSquareNode(data: JSValue, scene: CustomGameScene) {
        scene.squareNode = SquareSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
        scene.squareNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        scene.squareNode.nodeTouchDelegate = scene
        scene.squareNode.zPosition = 1
        
        //Json数据中Direction表示哪些方向可以进行连接，0-7，按逆时针右➡️左 8个方向
        if let jsonDirection = data["circleDirections"].array {
            var directionArray: [Directions] = [];
            for value in jsonDirection {
                directionArray.append(Directions(rawValue: Int(value.number!)))
            }
            
            directionArray.sortInPlace { (direction1: Directions, direction2: Directions) -> Bool in
                return direction1.rawValue < direction2.rawValue
            }
            directionArray.append(directionArray[0])
            
            scene.squareNode.circleDirectionNode = DirectionSpriteNode.init(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
            scene.squareNode.circleDirectionNode!.directions = directionArray
            scene.squareNode.isCircleDirectionNode = true
        }
        //判断是否存在BridgeNode
        if let directionValue = data["bridgeDirection"].number {
            let direction = FourDirection(rawValue: Int(directionValue))
            scene.squareNode.bridgeNode = BridgeSpriteNode.init(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!*2.0, height: data["nodeH"].number!))
            scene.squareNode.bridgeNode!.bridgeDirection = direction
            scene.squareNode.isBridgeNode = true
        }
        
        if let _ = data["isRedSpriteNode"].bool {
            scene.squareNode.redNode = RedColorSpriteNode.init(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!), isSquare: true)
            if let redNodeType = data["redSpriteType"].number {
                scene.squareNode.redNode?.redNodeType = redNodeType
            }
            scene.squareNode.isRedSpriteNode = true
        }
        
        scene.backgroundNode.addChild(scene.squareNode)
    }
    
    static func createAnimateNode(data: JSValue, scene: CustomGameScene) {
        scene.animateNode = AnimateSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
        scene.animateNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        scene.animateNode.zPosition = 10
        scene.backgroundNode.addChild(scene.animateNode)
    }
    
    static func createBlockNode(data: JSValue, scene: CustomGameScene) {
        let rotationValue = data["rotation"].number!
        let rotationAngle = rotationValue == 0 ? rotationValue : M_PI*rotationValue
        let blockNode = BlockSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!), rotation: CGFloat(rotationAngle))
        blockNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        blockNode.name = "Block"
        blockNode.zPosition = -10
        scene.backgroundNode.addChild(blockNode)
    }
    
    static func createMiddleLinkNode(data: JSValue, scene: CustomGameScene) {
        let middleLinkNode = MiddleLinkSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
        middleLinkNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        middleLinkNode.zPosition = 20
        scene.backgroundNode.addChild(middleLinkNode)
    }
    
    static func createRelationshipNode(data: JSValue, scene: CustomGameScene) {
        let relationshipNode = RelationshipSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
        relationshipNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        relationshipNode.zPosition = -1
        scene.backgroundNode.addChild(relationshipNode)
        if let otherNodeName = data["secondNodeName"].string {
            let nodeArray = scene.backgroundNode[otherNodeName]
            if let customNode = nodeArray.first as? CustomSpriteNode {
                relationshipNode.unableTouchNode = customNode
                customNode.userEnable = false
            }
        }
        
        if let firstNodeName = data["firstNodeName"].string {
            let nodeArray = scene.backgroundNode[firstNodeName]
            if let customNode = nodeArray.first as? CustomSpriteNode {
                customNode.relationshipLine = relationshipNode
            }
        }
        
        let rotationValue = data["rotation"].number!
        let rotationAngle = rotationValue == 0 ? rotationValue : M_PI*rotationValue
        relationshipNode.zRotation = CGFloat(rotationAngle)
    }
    
    static func createTwiceCommonNode(data: JSValue, scene: CustomGameScene) {
        let twiceCommonNode = TwiceCommonSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
        twiceCommonNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        twiceCommonNode.nodeTouchDelegate = scene
        twiceCommonNode.zPosition = 1
        if let nodeName = data["nodeName"].string {
            twiceCommonNode.name = nodeName;
        }
        if let _ = data["relationship"].bool {
            twiceCommonNode.isRelationship = true
        }
        scene.backgroundNode.addChild(twiceCommonNode)
    }
    
    static func createLockMiddleNode(data: JSValue, scene: CustomGameScene) {
        let lockNode = LockMiddleSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
        lockNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        lockNode.zPosition = 20
        scene.backgroundNode.addChild(lockNode)
    }
    
    static func createDoubleLineBlockNode(data: JSValue, scene: CustomGameScene) {
        let doubleLineNode = DoubleLineBlockSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: data["nodeW"].number!, height: data["nodeH"].number!))
        doubleLineNode.position = CGPoint(x: data["nodeX"].number!, y: data["nodeY"].number!)
        scene.backgroundNode.addChild(doubleLineNode)
        
        let directionValue = (Int)(data["direction"].number!)
        let direction = FourDirection(rawValue: directionValue);
        doubleLineNode.direction = direction;
        doubleLineNode.zPosition = -10
    }
}