//
//  CommUtil.swift
//  LinkAll
//
//  Created by che on 15/10/29.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import Foundation
import SpriteKit

//MARK: - Extension
extension SKColor {
    static func colorWithRed(red: Int, green: Int, blue: Int) -> SKColor {
        return SKColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

//MARK: - Protocol
//MARK: Node点击的代理事件
protocol NodeTouchDelegate {
    func nodeTouch(node: CustomSpriteNode)
}

//MARK: BackOrNext Node点击的代理事件
protocol BackOrNextNodeTouchDelegate {
    func backOrNextNodeTouch(node: BackOrNextSpriteNode)
}

//MARK: MainMenuNodeTouchDelegate
protocol MainMenuNodeTouchDelegate {
    func mainMenuNodeTouch(node: MainMenuSpriteNode)
}

//MARK: MenuNodeTouchDelegate
protocol MenuNodeTouchDelegate {
    func menuNodeTouch(node: MenuSpriteNode)
}

//MARK: RefreshNodeTouchDelegate
protocol RefreshNodeTouchDelegate {
    func refreshNodeTouch(node: RefreshSpriteNode)
}

//MARK: VoiceNodeTouchDelegate
protocol VoiceNodeTouchDelegate {
    func voiceNodeTouch(node: VoiceSpriteNode)
}

//MARK: - Struct
//MARK: 针对Points的检查方法
struct PointsCheck {
    //MARK: 判断所有的点是否处于X轴
    static func isXLineWithPoints(points: [CGPoint]) -> Bool {
        var isLine = true
        if points.count > 0 {
            let pointY = points.first?.y
            
            for point in points {
                if point.y != pointY {
                    isLine = false
                    break
                }
            }
        } else {
            isLine = false
        }
        return isLine
    }
    
    //MARK: 判断所有点是否处于Y轴
    static func isYLineWithPoints(points: [CGPoint]) -> Bool {
        var isLine = true
        if points.count > 0 {
            let pointX = points.first?.x
            
            for point in points {
                if point.x != pointX {
                    isLine = false
                    break
                }
            }
        } else {
            isLine = false
        }
        return isLine
    }
    
    //MARK: 判断所有点是否处于一条斜线
    static func isSlashWithPoints(points: [CGPoint]) -> Bool {
        var isLine = true
        if points.count >= 3 {
            let firstNodePosition = points.first!
            let lastNodePosition = points.last!
            let proportion = (lastNodePosition.x - firstNodePosition.x) / (lastNodePosition.y - firstNodePosition.y)
            
            for index in 1..<points.count-1 {
                let point = points[index]
                let proportion2 = (point.x - firstNodePosition.x) / (point.y - firstNodePosition.y)
                if proportion != proportion2 {
                    isLine = false
                    break
                }
            }
            
        } else {
            isLine = true
        }
        return isLine
    }
    
    //MARK: 检查某三个点是否在同一条线上, 同时需要中间的点位于node1和node3之间
    static func calculationWithNode(node1: SKNode, node2: SKNode, node3: SKNode) -> Bool {
        let node1X = node1.position.x
        let node1Y = node1.position.y
        
        let node2X = node2.position.x
        let node2Y = node2.position.y
        
        let node3X = node3.position.x
        let node3Y = node3.position.y
        
        if PointsCheck.isXLineWithPoints([node1.position, node3.position]) {
            if node2X < max(node1X, node3X) && node2X > min(node1X, node3X) {
                return node2Y == node1Y ? true : false
            } else {
                return false
            }
        } else if PointsCheck.isYLineWithPoints([node1.position, node3.position]) {
            if node2Y < max(node1Y, node3Y) && node2Y > min(node1Y, node3Y) {
                return node2X == node1X ? true : false
            } else {
                return false
            }
        } else {
            if PointsCheck.isSlashWithPoints([node1.position,node2.position,node3.position]) {
                if node2X > min(node1X, node3X) && node2X < max(node1X, node3X) {
                    return true
                } else {
                    return false
                }
            }else {
                return false
            }
        }
    }
}

//MARK: 针对Points的计算方法
struct PointsCaculator {
    //MARK: 计算两个点之间的距离
    static func lineWidthWithPoint(startPoint: CGPoint, endPoint: CGPoint) -> CGFloat {
        let xLine = startPoint.x - endPoint.x
        let yLine = startPoint.y - endPoint.y
        
        return sqrt(xLine*xLine + yLine*yLine)
    }
    
    //MARK: 计算两个点之间的角度
    static func rotateWithNode(startNode: SKNode, endNode: SKNode) -> CGFloat {
        let startPosition = startNode.position
        let endPosition = endNode.position
        if startPosition.x == endPosition.x {
            if startPosition.y < endPosition.y {
                return CGFloat(M_PI_2)
            } else {
                return CGFloat(-M_PI_2)
            }
        } else if startPosition.y == endPosition.y {
            if startPosition.x < endPosition.x {
                return 0
            } else {
                return CGFloat(M_PI)
            }
        } else {
            let proportion = (startPosition.y - endPosition.y) / (startPosition.x - endPosition.x)
            if proportion < 0 {
                if startPosition.x > endPosition.x {
                    return atan(proportion) + CGFloat(M_PI)
                } else {
                    return atan(proportion)
                }
            } else {
                if startPosition.x < endPosition.x {
                    return atan(proportion)
                } else {
                    return atan(proportion) + CGFloat(M_PI)
                }
            }
            
        }
    }
    
    static func lineDirectionWithStartNode(node: CustomSpriteNode, endNode: CustomSpriteNode) -> Directions? {
        var direction: Directions?
        let startPosition = node.position
        let endPosition = endNode.position
        if startPosition.x == endPosition.x && startPosition.y < endPosition.y {
            direction = Directions.Down
        } else if startPosition.x == endPosition.x && startPosition.y > endPosition.y {
            direction = Directions.UP
        } else if startPosition.y == endPosition.y && startPosition.x > endPosition.x {
            direction = Directions.Right
        } else if startPosition.y == endPosition.y && startPosition.x < endPosition.x {
            direction = Directions.Left
        } else if fabs(endPosition.y - startPosition.y) == fabs(endPosition.x - startPosition.x) {
            if startPosition.x < endPosition.x && startPosition.y < endPosition.y {
                direction = Directions.LeftDown
            } else if startPosition.x < endPosition.x && startPosition.y > endPosition.y {
                direction = Directions.LeftUp
            } else if startPosition.x > endPosition.x && startPosition.y < endPosition.y {
                direction = Directions.RightDown
            } else if startPosition.x > endPosition.x && startPosition.y > endPosition.y {
                direction = Directions.RightUp
            }
        }
        return direction
    }
    
    static func fourDirectionWithStartNode(startNode: CustomSpriteNode, endNode: CustomSpriteNode) -> FourDirection? {
        var direction: FourDirection = .OtherDirection
        let startPosition = startNode.position
        let endPosition = endNode.position
        if startPosition.x == endPosition.x {
            direction = FourDirection.Vertical
        } else if startPosition.y == endPosition.y {
            direction = FourDirection.Landscape
        } else if fabs(endPosition.y - startPosition.y) == fabs(endPosition.x - startPosition.x) {
            if (startPosition.x < endPosition.x && startPosition.y < endPosition.y) || (startPosition.x > endPosition.x && startPosition.y > endPosition.y) {
                direction = FourDirection.RightRotation
            } else if (startPosition.x < endPosition.x && startPosition.y > endPosition.y) || (startPosition.x > endPosition.x && startPosition.y < endPosition.y) {
                direction = FourDirection.LeftRotation
            }
        }
        return direction
    }
}

//MARK: UnSafePointer
struct UnSafePointer {
    static func trianglePoints(points: [CGPoint]) -> UnsafeMutablePointer<CGPoint> {
        let unSafePoints = UnsafeMutablePointer<CGPoint>.alloc(points.count)
        for index in 0..<points.count {
            unSafePoints[index] = points[index]
        }
        return unSafePoints
    }
}

struct Directions: OptionSetType {
    var rawValue:Int
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static let Right: Directions = Directions(rawValue: 0)
    static let RightDown: Directions = Directions(rawValue: 7)
    static let Down: Directions = Directions(rawValue: 6)
    static let LeftDown: Directions = Directions(rawValue: 5)
    static let Left: Directions = Directions(rawValue: 4)
    static let LeftUp: Directions = Directions(rawValue: 3)
    static let UP: Directions = Directions(rawValue: 2)
    static let RightUp: Directions = Directions(rawValue: 1)
}

struct FourDirection: OptionSetType {
    var rawValue: Int
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    static let Landscape: FourDirection = FourDirection(rawValue: 0)
    static let RightRotation: FourDirection = FourDirection(rawValue: 1)
    static let Vertical: FourDirection = FourDirection(rawValue: 2)
    static let LeftRotation: FourDirection = FourDirection(rawValue: 3)
    static let OtherDirection: FourDirection = FourDirection(rawValue: 4)
}

//MARK: - Enum
//MARK: TouchNode的目的
enum TouchNodeType {
    case OnlyLinkedNodeType
    case OnlyCancelNodeType
    case LinkedAndCancelNodeType
}

//MARK: - Let Value
//MARK: Menu Name Array
let menuNameArray = ["start up","roll out","through","bridge","alternate"]










