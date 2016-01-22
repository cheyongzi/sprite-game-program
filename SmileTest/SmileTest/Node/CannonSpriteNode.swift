//
//  CannonSpriteNode.swift
//  SmileTest
//
//  Created by che on 16/1/5.
//  Copyright © 2016年 cheyongzi. All rights reserved.
//

import SpriteKit

class CannonSpriteNode: SKSpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
