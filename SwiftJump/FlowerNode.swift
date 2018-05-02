//
//  FlowerNode.swift
//  SwiftJump
//
//  Created by Theo Shiao on 5/1/18.
//  Copyright © 2018 Theo Shiao. All rights reserved.
//

import SpriteKit

enum FlowerType:Int {
    case NormalFlower = 0
    case SpecialFlower = 1
}

class FlowerNode: GenericNode {
    
    var flowerType:FlowerType!
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 400)
        self.removeFromParent()
        return true
    }
}
