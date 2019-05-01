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
	var crabPhys = SKPhysicsBody()
    
    override func didMove(to view: SKView) {
        crabClaw = self.childNode(withName: "CrabClaw") as! SKSpriteNode
		crabPhys = crabClaw.physicsBody!
		
        let tapRec = UITapGestureRecognizer()
        
        tapRec.addTarget(self, action:#selector(GameScene.tappedView(_:) ))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         
    }
    
    @objc func tappedView(_ sender:UITapGestureRecognizer) {
        
        let point: CGPoint = sender.location(in: self.view)
        
        
    }
    
    
}
