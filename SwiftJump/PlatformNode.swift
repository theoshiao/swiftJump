//
//  PlatformNode.swift
//  SwiftJump
//
//  Created by Theo Shiao on 5/1/18.
//  Copyright © 2018 Theo Shiao. All rights reserved.
//

import SpriteKit

class PlatformNode: GenericNode {
    var platformType:PlatformType!
    
    override func collisionWithPlayer(player: SKNode) -> Bool {
        if (player.physicsBody?.velocity.dy)! < CGFloat(0) {
            print("hello")
            player.physicsBody?.velocity = CGVector(dx: player.physicsBody!.velocity.dx, dy: 250)
            
            if platformType == PlatformType.breakableBrick {
                self.removeFromParent()
            }
        }
        return false
    }
}
