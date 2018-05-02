//
//  GameScene.swift
//  SwiftJump
//
//  Created by Theo Shiao on 4/30/18.
//  Copyright © 2018 Theo Shiao. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background:SKNode!
    var midground:SKNode!
    var foreground:SKNode!
    
    var hud:SKNode!
    
    var player:SKNode!
    
    var scaleFactor:CGFloat!
    
    var startButton = SKSpriteNode(imageNamed: "TapToStart")
    
    var endOfGamePosition = 0
    
    let motionManager = CMMotionManager()
    
    var xAcceleration:CGFloat = 0.0
    
    var scoreLabel:SKLabelNode!
    var flowerLabel:SKLabelNode!
    
    var playersMaxY:Int!
    
    var gameOver = false
    
    
    
    //
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override init(size:CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
        scaleFactor = self.size.width / 320
        
        let levelData = GameHandler.sharedInstance.levelData
        
        background = createBackground()
        addChild(background)
        
        midground = createMidground()
        addChild(midground)
        
        foreground = SKNode()
        addChild(foreground)
        
        player = createPlayer()
        foreground.addChild(player)
        
        let platforms = levelData!["Platforms"] as! NSDictionary
        let platformPatterns = platforms["Patterns"] as! NSDictionary
        let platformPositions = platforms["Positions"] as! [NSDictionary]
        for platformPosition in platformPositions {
            let x = (platformPosition["x"] as AnyObject).floatValue
            let y = (platformPosition["y"] as AnyObject).floatValue
            let pattern = platformPosition["pattern"] as! NSString
            
            let platformPattern = platformPatterns[pattern] as! [NSDictionary]
            for platformPoint in platformPattern {
                let xValue = (platformPoint["x"] as AnyObject).floatValue
                let yValue = (platformPoint["y"] as AnyObject).floatValue
                let type = PlatformType(rawValue: (platformPoint["type"]! as AnyObject).integerValue)
                let xPosition = CGFloat(xValue! + x!)
                let yPosition = CGFloat(yValue! + y!)
                
                let platformNode = createPlatformAtPosition(position: CGPoint(x: xPosition, y: yPosition), ofType: type!)
                foreground.addChild(platformNode)
                
            }
        }
        
        //        let platform = createPlatformAtPosition(position: CGPoint(x: 160, y: 320), ofType: PlatformType.normalBrick)
        //        foreground.addChild(platform)
        
        let flower = createFlowerAtPosition(position: CGPoint(x: 160, y: 220), ofType: FlowerType.SpecialFlower)
        foreground.addChild(flower)
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        motionManager.accelerometerUpdateInterval = 0.2
        
        
    }
    
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: xAcceleration * 400, dy: player.physicsBody!.velocity.dy)
        if player.position.x < -20 {
            player.position = CGPoint(x: self.size.width + 20, y: player.position.y)
        } else if (player.position.x > self.size.width + 20) {
            player.position = CGPoint(x: -20, y: player.position.y)
        }
    }
    func didBeginContact(contact: SKPhysicsContact) {
        var otherNode: SKNode!
        if contact.bodyA.node != player {
            otherNode = contact.bodyA.node
        } else {
            otherNode = contact.bodyB.node
        }
        (otherNode as! GenericNode).collisionWithPlayer(player: player)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.physicsBody?.isDynamic = true
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        foreground.enumerateChildNodes(withName: "PLATFORMNODE") {(node, stop) -> Void in
            let platform = node as! PlatformNode
            platform.shouldRemoveNode(playerY: self.player.position.y)
            
            self.foreground.enumerateChildNodes(withName: "FLOWERNODE") { (node, stop) -> Void in
                let flower = node as! FlowerNode
                flower.shouldRemoveNode(playerY: self.player.position.y)
                
            }
            
        }
        if player.position.y > 200 {
            background.position = CGPoint(x: 0, y: -((player.position.y - 200)/10))
            midground.position = CGPoint(x: 0, y: -((player.position.y - 200)/4))
            foreground.position = CGPoint(x: 0, y: -((player.position.y - 200)))
        }
    }
}

