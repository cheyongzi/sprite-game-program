//
//  CustomGameScene.swift
//  LinkAll
//
//  Created by che on 15/10/30.
//  Copyright © 2015年 cheyongzi. All rights reserved.
//

import SpriteKit

class CustomGameScene: SKScene,NodeTouchDelegate {

    var squareNode: SquareSpriteNode!
    var animateNode: AnimateSpriteNode!
    
    //MARK: 表示当前最后一个连接的Node位置
    var currentNode: CustomSpriteNode!
    
    //MARK: 游戏中每连接一个Node就将Node的position放进数组，取消连接则从数组中删除
    var connectedPoints: [CGPoint] = []
    
    //MARK:标志游戏中所有的点是否全部连接
    var isAllSpriteNodeLinked: Bool = false
    
    //MARK: 视图
    var backgroundNode: BackgroundSpriteNode!
    
    var isCanTouchNode: Bool = true
    
    let voiceState = NSUserDefaults.standardUserDefaults().integerForKey("VoiceState")
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        let backgroundImg = SKSpriteNode(imageNamed: "background.jpg")
        backgroundImg.position = (self.view?.center)!
        backgroundImg.zPosition = -1000
        addChild(backgroundImg)
        
        backgroundNode = BackgroundSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 300, height: 450))
        backgroundNode.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundNode.position = CGPoint(x: size.width/2 - 150, y: size.height/2 - 225)
        addChild(backgroundNode)
    }
    
    override func update(currentTime: NSTimeInterval) {
        super.update(currentTime)
    }
    
    //MARK: - CustomSpriteNode点击事件方法
    func nodeTouch(touchNode: CustomSpriteNode) {
        if !isCanTouchNode {
            return
        }
        if squareNode.linkedLine != nil {
            return
        }
        if currentNode.isEqualToNode(touchNode) {
            return
        }
        isCanTouchNode = false
        //如果点击的点为TwiceNode，则需要判断CurrentNode与TouchNode的连线与将要发生的连线位置是否一样，如果一样，则为取消操作
        if let twiceNode = touchNode as? TwiceCommonSpriteNode {
            if twiceNode.isTouchOnceTime && !twiceNode.isLinked {
                self.twiceNodeTouchCheck(touchNode)
                return
            }
        }
        
        //如果点击的node为BridgeCommonSpriteNode，则需要判断bridgeNode是否连接，同时方向是否一致
        if touchNode.isBridgeNode {
            if !touchNode.isLinked {
                if let direction = PointsCaculator.fourDirectionWithStartNode(currentNode, endNode: touchNode) {
                    if touchNode.bridgeNode!.bridgeDirection.rawValue == direction.rawValue {
                        animateFailed(touchNode, scale: 1, soudName: "failed")
                        return
                    }
                }
                
            }
        }
        
        //如果点击的Node为DirectionNode，则需要判断Direction是否与连线相同
        if touchNode.isCircleDirectionNode {
            if currentNode.isCircleDirectionNode {
                self.directionNodeTouchCheck(touchNode, endNode: currentNode, directionNode: currentNode, touchNode: touchNode)
                return
            }
            if !touchNode.isLinked {
                self.directionNodeTouchCheck(currentNode, endNode: touchNode, directionNode: touchNode, touchNode: touchNode)
                return
            }
        }
        
        if touchNode.isLinked {
            self.cancelLinkNode(touchNode)
        } else {
            if currentNode.isCircleDirectionNode {
                self.directionNodeTouchCheck(touchNode, endNode: currentNode, directionNode: currentNode, touchNode: touchNode)
                return
            }
            self.linkNode(touchNode)
        }
    }
    
    //MARK: - 判断已经连接的点是否允许返回
    func isAllowBackToNode(node: CustomSpriteNode) -> Bool {
        if let index = connectedPoints.indexOf(node.position) {
            var newPoints = Array(connectedPoints[index..<connectedPoints.count])
            if let twiceNode = currentNode as? TwiceCommonSpriteNode {
                if !twiceNode.isLinked {
                    newPoints.append(twiceNode.position)
                }
            }
            //如果数组中只有两个点，数组中的点都在一条线上
            if PointsCheck.isXLineWithPoints(newPoints) ||
                PointsCheck.isYLineWithPoints(newPoints) ||
                PointsCheck.isSlashWithPoints(newPoints){
                    return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
    
    //MARK: - 连接或取消连接数组中的Node
    private func linkOrCancelLinkNodes(touchNode: CustomSpriteNode, middleNodes: [CustomSpriteNode],touchNodeType: TouchNodeType) {
        let newNodesArr = reCompareNodes(middleNodes)
        switch touchNodeType {
        case .OnlyCancelNodeType:
            animateWithNodes(newNodesArr, linkedNodes: [])
        case .OnlyLinkedNodeType:
            let linkedLine = lineWithStartNode(currentNode, endNode: touchNode);
            if isLineIntersectBlock(linkedLine) || isLineIntersectDoubleLineBlock(linkedLine, startNode: currentNode, endNode: touchNode) {
                animateFailed(touchNode,scale: 1, soudName: "block")
                return
            } else {
                //判断需要进行连接的Node是否包含两个以上的RedNode
                if isContainMoreRedNode(newNodesArr) {
                    linkedLine.removeFromParent()
                    return
                }
                changeMiddleLinkNodeState(currentNode, endNode: touchNode, tag: true)
                animateWithNodes([], linkedNodes: newNodesArr)
            }
            linkedLine.removeFromParent()
        case .LinkedAndCancelNodeType:
            var (linkedNodes, noneLinkedNodes) = spliteNodes(middleNodes)
            if let lastNode = linkedNodes.last {
                if isAllowBackToNode(lastNode) {
                    let linkedLine = lineWithStartNode(lastNode, endNode: touchNode);
                    if isLineIntersectBlock(linkedLine) || isLineIntersectDoubleLineBlock(linkedLine, startNode: currentNode, endNode: touchNode) {
                        animateFailed(touchNode,scale: 1, soudName: "block")
                        return
                    } else {
                        noneLinkedNodes.insert(lastNode, atIndex: 0)
                        linkedNodes.removeLast()
                        //判断需要进行连接的Node是否包含两个以上的RedNode
                        if isContainMoreRedNode(noneLinkedNodes) {
                            linkedLine.removeFromParent()
                            return
                        }
                        animateWithNodes(linkedNodes, linkedNodes: noneLinkedNodes)
                        changeMiddleLinkNodeState(linkedNodes.first!, endNode: lastNode, tag: false)
                        changeMiddleLinkNodeState(lastNode, endNode: touchNode, tag: true)
                    }
                    linkedLine.removeFromParent()
                } else {
                    animateFailed(touchNode,scale: 1, soudName: "failed")
                    return
                }
            }
        }
        if voiceState == 0 {
            self.runAction(SKAction.playSoundFileNamed("menu", waitForCompletion: false))
        }
        if touchNodeType == TouchNodeType.OnlyCancelNodeType {
            self.animateNode.actionMoveTo(touchNode.position, duration: Double(newNodesArr.count)*0.3){
                self.animateFinished(touchNode)
            }
        } else {
            self.animateNode.actionMoveTo(touchNode.position, duration: Double(newNodesArr.count-1)*0.3){
                self.animateFinished(touchNode)
            }
        }
    }
    
    //MARK: - 判断需要连接的Node中是否包含了两个以上的RedSpriteKitNode
    func isContainMoreRedNode(nodes: [CustomSpriteNode]) -> Bool {
        var isContainMoreRedNode = false
        var redSpriteNodeArray: [CustomSpriteNode] = []
        for node in nodes {
            if node.isRedSpriteNode {
                redSpriteNodeArray.append(node)
            }
        }
        
        //判断相邻的两个redSpriteNode的redNodeType是否相同
        if redSpriteNodeArray.count > 1 {
            for i in 0..<redSpriteNodeArray.count-1 {
                if redSpriteNodeArray[i].redNode?.redNodeType == redSpriteNodeArray[i+1].redNode?.redNodeType {
                    isContainMoreRedNode = true
                    animateFailed(redSpriteNodeArray[i+1], scale: 1, soudName: "failed")
                    break
                }
            }
        }
        
        return isContainMoreRedNode;
    }
    
    //MARK: - 动画运行结束之后执行的操作
    func animateFinished(touchNode: CustomSpriteNode) {
        isCanTouchNode = true
        if !touchNode.isEqualToNode(self.squareNode) {
            self.changeStateWithNode(touchNode, state: true)
        } else {
            touchNode.linkedLine?.isLastLinkeLine = false
        }
        currentNode = touchNode
    }
    
    //MARK: - 修改Node的连线的状态
    func changeStateWithNode(node: CustomSpriteNode, state: Bool) {
        if let lineNode = node.linkedLine {
            if !lineNode.locked {
                node.linkedLine?.isLastLinkeLine = state
            }
        } else {
            if let twiceNode = node as? TwiceCommonSpriteNode {
                if let secondLine = twiceNode.secondLinkedLineNode {
                    if !secondLine.locked {
                        twiceNode.secondLinkedLineNode?.isLastLinkeLine = state
                    }
                }
            }
        }
    }
    
    //MARK: - 计算两个Node连线上存在的其他的Node,返回数组类型
    func lineMiddleElementWithNode(startNode: CustomSpriteNode, endNode: CustomSpriteNode) -> [CustomSpriteNode] {
        var middleNodeArray: [CustomSpriteNode] = []
        for subNode in backgroundNode.children {
            if let customNode = subNode as? CustomSpriteNode {
                if customNode != startNode && customNode != endNode {
                    if PointsCheck.calculationWithNode(startNode, node2: customNode, node3: endNode) {
                        //判断连接点中间是否存在MiddleLinkSpriteNode，如果存在则需要特殊处理
                        if let _ = customNode as? MiddleLinkSpriteNode {
                            
                        }
                        else {
                            if customNode.isBridgeNode {
                                //如果中间点为bridgenode，则需要判断bridge是否与连接的点一致
                                if let direction = PointsCaculator.fourDirectionWithStartNode(startNode, endNode: endNode) {
                                    if direction.rawValue != customNode.bridgeNode!.bridgeDirection.rawValue {
                                        middleNodeArray.append(customNode)
                                    }
                                }
                            } else {
                                middleNodeArray.append(customNode)
                            }
                        }
                    }
                }
            }
        }
        return middleNodeArray
    }
    
    //MARK: - 判断两个Node连线之间是否存在LockMiddleSpriteNode
    func isLineMiddleLockElementWithNode(startNode: CustomSpriteNode, endNode: CustomSpriteNode) -> Bool {
        var hasLockMiddleSpriteNode = false
        for subNode in backgroundNode.children {
            if let lockMiddleNode = subNode as? LockMiddleSpriteNode {
                if PointsCheck.calculationWithNode(startNode, node2: lockMiddleNode, node3: endNode) {
                    hasLockMiddleSpriteNode = true
                    break
                }
            }
        }
        return hasLockMiddleSpriteNode
    }
    
    //MARK: - 从ConnectedPoints数组中删除已连接的Node position
    func removePositionWithNode(node: CustomSpriteNode) {
        node.isLinked = false
        if let index = connectedPoints.indexOf(node.position) {
            connectedPoints.removeAtIndex(index)
        }
    }
    
    //MARK: - 根据传入的需要取消连接和需要连接的Node数组进行动画
    func animateWithNodes(var cancelNodes: [CustomSpriteNode], var linkedNodes: [CustomSpriteNode]) {
        if cancelNodes.count > 0 {
            let startNode = cancelNodes[0]
            removeLinkedLine(startNode) {
                cancelNodes.removeFirst()
                self.animateWithNodes(cancelNodes, linkedNodes: linkedNodes)
            }
        } else {
            if linkedNodes.count > 1 {
                let startNode = linkedNodes[0]
                let endNode = linkedNodes[1]
                animateWithNode(startNode, endNode: endNode) {
                    linkedNodes.removeFirst()
                    self.animateWithNodes([],linkedNodes: linkedNodes)
                }
            }
        }
    }
    
    //MARK: - 当两个点之间可以进行连线时，执行此方法
    private func animateWithNode(startNode: CustomSpriteNode, endNode: CustomSpriteNode, complete: () -> Void) {
        //如果开始点是TwiceNode，则需要判断是何种状态
        self.changeStateWithNode(startNode, state: false)
        
        let linkedLine = lineWithStartNode(startNode, endNode: endNode)
        linkedLine.animateWithScale(1){
            complete()
        }
        if isLineMiddleLockElementWithNode(startNode, endNode: endNode) {
                linkedLine.locked = true
            }
        //如果endNode为TwiceNode，则需要判断是否为第一次连接
        if let twiceSpirteNode = endNode as? TwiceCommonSpriteNode {
            if !twiceSpirteNode.isTouchOnceTime {
                twiceSpirteNode.isTouchOnceTime = true
                twiceSpirteNode.secondLinkedLineNode = linkedLine
                return
            }
        }
        //如果连接的node为bridgecommonspritenode则需要做特殊处理
        if endNode.isBridgeNode {
            if let direction  = PointsCaculator.fourDirectionWithStartNode(startNode, endNode: endNode) {
                if endNode.bridgeNode!.bridgeDirection.rawValue == direction.rawValue {
                    return
                }
            }
        }
        endNode.linkedLine = linkedLine
        endNode.isLinked = true
        connectedPoints.append(endNode.position)
    }
    
    //MARK: - 删除某个Node的连接线
    private func removeLinkedLine(node: CustomSpriteNode, complete: () -> Void) {
        //首先判断删除的点是否为TwiceNode，如果为则需要判断
        if let twiceSpirteNode = node as? TwiceCommonSpriteNode {
            if !twiceSpirteNode.isLinked {
                twiceSpirteNode.secondLinkedLineNode?.animateWithScale(0) {
                    twiceSpirteNode.isTouchOnceTime = false
                    complete()
                    return
                }
            }
        }
        
        node.linkedLine?.animateWithScale(0) {
            self.removePositionWithNode(node)
            complete()
        }
    }
    
    //MARK: - 当TouchNode不可到达时之行该方法
    func animateFailed(touchNode: CustomSpriteNode, scale: CGFloat, soudName: String) {
        if voiceState == 0 {
            self.runAction(SKAction.playSoundFileNamed(soudName, waitForCompletion: false))
        }
        let linkedLine = lineWithStartNode(currentNode, endNode: touchNode)
        self.animateNode.actionMoveTo(touchNode.position, duration: 0.3*Double(scale)) {
            self.animateNode.actionMoveTo(self.currentNode.position, duration: 0.3*Double(scale)) {
                self.isCanTouchNode = true
            }
        }
        linkedLine.animateWithScale(scale){
            linkedLine.animateWithScale(0){
            }
        }
    }
    
    //MARK: - 将Node数组分解为已连接数组和未连接数组
    func spliteNodes(nodes: [CustomSpriteNode]) -> ([CustomSpriteNode], [CustomSpriteNode]) {
        var linkedNodes: [CustomSpriteNode] = []
        var noneLinkedNodes: [CustomSpriteNode] = []
        let newNodesArr = reCompareNodes(nodes)
        for node in newNodesArr {
            if node.isLinked {
                linkedNodes.append(node)
            } else {
                noneLinkedNodes.append(node)
            }
        }
        return (linkedNodes, noneLinkedNodes)
    }
    
    //MARK: - 重新排列数组中的node顺序，按照与当前点的距离进行排序,由近到远
    func reCompareNodes(var nodes: [CustomSpriteNode]) -> [CustomSpriteNode] {
        if nodes.count > 1 {
            for i in 0..<nodes.count {
                for j in i+1..<nodes.count {
                    let length1 = PointsCaculator.lineWidthWithPoint(currentNode.position, endPoint: nodes[i].position)
                    let length2 = PointsCaculator.lineWidthWithPoint(currentNode.position, endPoint: nodes[j].position)
                    if length1 > length2 {
                        let temp = nodes[j]
                        nodes[j] = nodes[i]
                        nodes[i] = temp
                    }
                }
            }
        }
        return nodes
    }
    
    //MARK: - 检查连线是否与Block相交
    func isLineIntersectBlock(lineNode: LinkedLineSpriteNode) -> Bool {
        var isLineIntersectBlock = false
        let blockNodes = backgroundNode["Block"]
        for node in blockNodes {
            if node.intersectsNode(lineNode) {
                isLineIntersectBlock = true
                break
            }
        }
        
        for node in backgroundNode.children {
            if let lockedLineNode = node as? LinkedLineSpriteNode {
                if lockedLineNode.locked {
                    if lockedLineNode.intersectsNode(lineNode) {
                        isLineIntersectBlock = true
                        break
                    }
                }
            }
        }
        return isLineIntersectBlock
    }
    
    //MARK: - 检查连线是否与DoubleLineBlockNode相交
    func isLineIntersectDoubleLineBlock(lineNode: LinkedLineSpriteNode, startNode: CustomSpriteNode, endNode: CustomSpriteNode) -> Bool {
        var isLineIntersectBlock = false
        let doubleLineBlocks = backgroundNode["DoubleBlock"]
        for node in doubleLineBlocks {
            if let doubleLineBlockNode = node as? DoubleLineBlockSpriteNode {
                if doubleLineBlockNode.intersectsNode(lineNode) {
                    if let direction = PointsCaculator.fourDirectionWithStartNode(startNode, endNode: endNode) {
                        if direction != doubleLineBlockNode.direction {
                            isLineIntersectBlock = true
                            break
                        }
                    }
                }
            }
        }
        return isLineIntersectBlock;
    }
    
    //MARK: - 返回两个点之间的连线
    func lineWithStartNode(node: CustomSpriteNode, endNode: CustomSpriteNode) -> LinkedLineSpriteNode {
        let lineWidth = PointsCaculator.lineWidthWithPoint(node.position, endPoint: endNode.position)-5
        let angle = PointsCaculator.rotateWithNode(node,endNode: endNode)
        
        let linkedLine = LinkedLineSpriteNode(texture: nil, color: SKColor.clearColor(), size: CGSize(width: lineWidth, height: 1))
        linkedLine.position = node.position
        linkedLine.zPosition = -1
        //backgroundNode.insertChild(linkedLine, atIndex: 2)
        backgroundNode.addChild(linkedLine)
        linkedLine.zRotation = angle
        return linkedLine;
    }
    
    //MARK: - TwiceNode touch check
    func twiceNodeTouchCheck(touchNode: CustomSpriteNode) {
        let lineNode = lineWithStartNode(touchNode, endNode: currentNode);
        if lineNode.position == currentNode.linkedLine?.position {
            self.cancelLinkNode(touchNode)
        } else {
            if let otherNode = currentNode as? TwiceCommonSpriteNode {
                if otherNode.isLinked {
                    return;
                } else {
                    if lineNode.position == otherNode.secondLinkedLineNode?.position {
                        self.cancelLinkNode(touchNode)
                    }
                }
            } else {
                self.linkNode(touchNode)
            }
        }
        lineNode.removeFromParent()
    }
    
    //MARK: - DirectionNode touch check
    func directionNodeTouchCheck(startNode: CustomSpriteNode, endNode: CustomSpriteNode, directionNode: CustomSpriteNode, touchNode: CustomSpriteNode) {
        if let direction = PointsCaculator.lineDirectionWithStartNode(startNode, endNode: endNode) {
            if directionNode.circleDirectionNode!.directions.contains(direction) {
                self.linkNode(touchNode)
            } else {
                animateFailed(touchNode,scale: 1, soudName: "block")
            }
        } else {
            animateFailed(touchNode,scale: 1, soudName: "block")
        }
    }
    
    //MARK: - 取消Node的连接
    func cancelLinkNode(touchNode: CustomSpriteNode) {
        //如果touchNode已经被连接，需要判断currentNode与touchNode之间的路线是否允许返回
        if isAllowBackToNode(touchNode) {
            var cancelMiddleArray = lineMiddleElementWithNode(currentNode, endNode: touchNode)
            cancelMiddleArray.append(currentNode)
            changeMiddleLinkNodeState(currentNode, endNode: touchNode, tag: false)
            linkOrCancelLinkNodes(touchNode, middleNodes: cancelMiddleArray, touchNodeType: TouchNodeType.OnlyCancelNodeType)
        } else {
            animateFailed(touchNode,scale: 1, soudName: "failed")
            return
        }
    }
    
    //MARK: - 连接Node
    func linkNode(touchNode: CustomSpriteNode) {
        //如果touchNode未连接，首先获取touchNode与currentNode之间的其他Node
        var middleNodeArray = lineMiddleElementWithNode(currentNode, endNode: touchNode)
        var isMiddleNodeContainedLinkedNode = false
        for node in middleNodeArray {
            if node.isEqualToNode(squareNode) {
                animateFailed(node, scale: 1, soudName: "failed")
                return
            }
        }
        for node in middleNodeArray {
            //判断中间点中是否存在DirectionSpriteNode
            if node.isCircleDirectionNode {
                if let directionNode = node.circleDirectionNode {
                    if !node.isLinked {
                        let startDirection = PointsCaculator.lineDirectionWithStartNode(currentNode, endNode: node)
                        let endDirection = PointsCaculator.lineDirectionWithStartNode(touchNode, endNode: node)
                        if startDirection != nil && endDirection != nil {
                            if !directionNode.directions.contains(startDirection!) || !directionNode.directions.contains(endDirection!) {
                                animateFailed(node, scale: 1, soudName: "block")
                                return
                            }
                        } else {
                            animateFailed(node, scale: 1, soudName: "block")
                            return
                        }
                    }
                }
            }
        }
        for node in middleNodeArray {
            if node.isLinked {
                isMiddleNodeContainedLinkedNode = true
                break
            }
        }
        //MARK: 首先判断TouchNode是否为SquareNode，如果是则需要判断Scene中其他的点是否全部已连接
        if touchNode.isEqualToNode(squareNode) {
            if isMiddleNodeContainedLinkedNode {
                animateFailed(touchNode, scale: 1, soudName: "failed")
                return
            }
            var isAllNodeLinked = true
            //判断连接点中是否包含需要两次点击的点
            for node in middleNodeArray {
                if let twiceNode = node as? TwiceCommonSpriteNode {
                    if !twiceNode.isTouchOnceTime {
                        isAllNodeLinked = false
                    }
                }
            }
            //判断其他的Node是否已经全部连接
            if isAllNodeLinked {
                for node in backgroundNode.children {
                    if let customNode = node as? CustomSpriteNode {
                        if let _ = middleNodeArray.indexOf(customNode) {
                            
                        } else {
                            if !customNode.isLinked && !customNode.isEqualToNode(touchNode) {
                                isAllNodeLinked = false
                                break
                            }
                        }
                    }
                }
            }
            
            if isAllNodeLinked {
                isAllSpriteNodeLinked = true
            } else {
                animateFailed(touchNode,scale: 1, soudName: "failed")
                return
            }
        }
        middleNodeArray.append(currentNode)
        middleNodeArray.append(touchNode)
        if isMiddleNodeContainedLinkedNode {
            linkOrCancelLinkNodes(touchNode, middleNodes: middleNodeArray, touchNodeType: TouchNodeType.LinkedAndCancelNodeType)
        } else {
            linkOrCancelLinkNodes(touchNode, middleNodes: middleNodeArray, touchNodeType: TouchNodeType.OnlyLinkedNodeType)
        }
    }
    
    //修改两个点中间的MiddleSpriteNode的状态
    func changeMiddleLinkNodeState(startNode: CustomSpriteNode, endNode: CustomSpriteNode, tag: Bool) {
        for subNode in backgroundNode.children {
            if let customNode = subNode as? CustomSpriteNode {
                if customNode != startNode && customNode != endNode {
                    if PointsCheck.calculationWithNode(startNode, node2: customNode, node3: endNode) {
                        if let middleNode = customNode as? MiddleLinkSpriteNode {
                            if tag {
                                middleNode.isLinked = true
                                middleNode.middleLinkedLineArray.append(1)
                            } else {
                                middleNode.middleLinkedLineArray.removeLast()
                                if middleNode.middleLinkedLineArray.count == 0 {
                                    middleNode.isLinked = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
