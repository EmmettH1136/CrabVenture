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
    let tapRec = UITapGestureRecognizer()
    

    
    override func didMove(to view: SKView) {
        
        crabClaw = self.childNode(withName: "CrabClaw") as! SKSpriteNode
		crabPhys = crabClaw.physicsBody!
		
        
        
        tapRec.addTarget(self, action:#selector(GameScene.tappedView(_:) ))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
    }
    
    
    
    @objc func tappedView(_ sender:UITapGestureRecognizer) {
        
        let initialPosition = CGPoint(x: crabClaw.position.x, y: crabClaw.position.y)
        
        
        let crosshairPoint: CGPoint = CGPoint(x: 0, y: 0)
        
        var viewLocation = tapRec.location(in: view)
        viewLocation = crosshairPoint
        
        
        let moveToAction = SKAction.move(to: viewLocation, duration: 0.3)
        let moveClawBackAction = SKAction.move(to: initialPosition, duration: 0.7)
        
        self.crabClaw.run(moveToAction)
        
        
        if CGPoint(x: crabClaw.position.x, y: crabClaw.position.y) == CGPoint(x: 0, y: 0) {
            self.crabClaw.run(moveClawBackAction)
        }
        
        
    }
    
    func removeAllGestures(){
        
        for gesture in (self.view?.gestureRecognizers)! {
            
            self.view?.removeGestureRecognizer(gesture)
            
        }
        // for scene transitions
    }
}
