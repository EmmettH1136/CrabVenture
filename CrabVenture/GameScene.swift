//
//  GameScene.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 4/30/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var crabClaw = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        crabClaw = self.childNode(withName: "SKSpriteNode") as! SKSpriteNode
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
}
