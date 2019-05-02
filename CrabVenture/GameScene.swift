//
//  GameScene.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 4/30/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//


import SpriteKit
import GameplayKit

//Made these lines of code to determine random numbers
func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}

class GameScene: SKScene {
    var crabClaw = SKSpriteNode()
	var crabPhys = SKPhysicsBody()
    var swordFishNode = SKSpriteNode()
	var swordFish = Enemy("SwordFish", 1, SKSpriteNode(), CGVector(dx: Int.random(in: 100...200), dy: 0))
    var swordFishPhys = SKPhysicsBody()
    let tapRec = UITapGestureRecognizer()
    

	var health = 1
    
    override func didMove(to view: SKView) {
        
        crabClaw = self.childNode(withName: "CrabClaw") as! SKSpriteNode
		crabPhys = crabClaw.physicsBody!
        swordFishNode = self.childNode(withName: "SwordFish") as! SKSpriteNode
        swordFishPhys = swordFishNode.physicsBody!
		swordFish.body = swordFishNode
		
        
        
        tapRec.addTarget(self, action:#selector(GameScene.tappedView(_:) ))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
        
        // Starting the sworfish movement in here for now can move to a function later
//        let actualDuration = random(min: 10, max: 25)
//
//        let actionMove = SKAction.move(to: CGPoint(x: 640,y: 320), duration: TimeInterval(actualDuration))
//        let ahhhhhh = SKAction.move(by: swordFish.speed, duration: TimeInterval(actualDuration))
//        let actionMoveDone = SKAction.removeFromParent()
//        swordFishNode.run(SKAction.sequence([ahhhhhh, actionMoveDone]))
        swordFishPhys.velocity = swordFish.speed
        
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
	
	override func update(_ currentTime: TimeInterval) {
		if health == 0 {
			print("yuh oh you lost")
		}
	}
	func makePath() {
		// move this when the new scene is made
		let outTiles : [String] = []
		let tiles : [String] = []
		let poss : [String] = []
		let length = Int.random(in: 5...25)
	}
}
