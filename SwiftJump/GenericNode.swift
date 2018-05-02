//
//  GenericNode.swift
//  SwiftJump
//
//  Created by Theo Shiao on 4/30/18.
//  Copyright © 2018 Theo Shiao. All rights reserved.
//

import SpriteKit

struct CollisionBitMask {
    static let Player:UInt32 = 0x00
    static let Flower:UInt32 = 0x01
    static let Brick:UInt32 = 0x02
}

enum PlatformType:Int {
    case normalBrick = 0
    case breakableBrick = 1
}

class GenericNode: SKNode {
    func collisionWithPlayer (player: SKNode) -> Bool {
        return false
    }
    
    func shouldRemoveNode (playerY: CGFloat) {
        if playerY > self.position.y + 300 {
            self.removeFromParent()
        }
    }
}
