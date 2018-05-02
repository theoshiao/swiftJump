//
//  GameHandler.swift
//  SwiftJump
//
//  Created by Dev Thakkar on 5/1/18.
//  Copyright © 2018 Theo Shiao. All rights reserved.
//

import Foundation
class GameHandler {
    var score: Int
    var highScore: Int
    var flowers: Int
    var levelData:NSDictionary!
    class var sharedInstance: GameHandler {
        struct Singleton {
            static let instance = GameHandler()
        }
        return Singleton.instance
    }
    init(){
        score = 0
        highScore = 0
        flowers = 0
        
        let userDefaults = UserDefaults.resetStandardUserDefaults()
        
        //        highScore = userDefaults.integerForKey("highScore")
        //        flowers = userDefaults.integerForKey("flowers")
        
        if let path = Bundle.main.path(forResource: "Level01", ofType: "plist") {
            if let level = NSDictionary(contentsOfFile: path) {
                levelData = level
            }
            
            
        }
    }
    func saveGameStats() {
        highScore = max(score, highScore)
        let userDefaults = UserDefaults.standard
        userDefaults.set(highScore, forKey: "highScore")
        userDefaults.set(flowers, forKey: "flowers")
        userDefaults.synchronize()
    }
}

