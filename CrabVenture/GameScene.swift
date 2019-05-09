//
//  GameScene.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 4/30/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//Made these lines of code to determine random numbers
func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    return random() * (max - min) + min
}
//or just use the already specified random functions

let clawCategory : UInt32 = 1
let enemyCategory : UInt32 = 2
let rightCategory : UInt32 = 4

class GameScene: SKScene, SKPhysicsContactDelegate {
    var crabClaw = SKSpriteNode()
	var crabPhys = SKPhysicsBody()
    var swordFishNode = SKSpriteNode()
	var swordFish = Enemy("SwordFish", 1, SKSpriteNode(), CGVector(dx: Int.random(in: 100...400), dy: 0), 0)
    var swordFishPhys = SKPhysicsBody()
	var cleaverNode = SKSpriteNode()
	var cleaver = Enemy("Cleaver", 1, SKSpriteNode(), CGVector(dx: Int.random(in: 400...800), dy: 0), 2)
	var cronched = 0
    let tapRec = UITapGestureRecognizer()
	var label = SKLabelNode()
	var backgroundNode = SKSpriteNode()
	var timer = Timer()
	var seconds = 0.1
	var isTimerRunning = false
	var initialPosition = CGPoint(x: 288.709, y: -300.153)
	var moveClawBackAction = SKAction()
	var enemyP = CGPoint()
	var contactie = 0
	var enemies : [Enemy] = []
	var enemy = Enemy("boop", 0, SKSpriteNode(), CGVector(), 1)
	
	func runTimer() {
		timer = Timer.scheduledTimer(timeInterval: 0.05, target: self,   selector: (#selector(GameScene.updateTimer)), userInfo: nil, repeats: true)
		isTimerRunning = true
	}
	@objc func updateTimer() {
		if isTimerRunning {
			if seconds <= 0 {
				timer.invalidate()
				seconds = 0.1
				isTimerRunning = false
				self.crabClaw.run(moveClawBackAction)
			} else {
				seconds -= 0.05
			}
		}
	}
	

	var health = 1
    
    override func didMove(to view: SKView) {
        
		physicsWorld.contactDelegate = self
		
		enemies = [swordFish, cleaver]
		
		
		cronched = 0
        crabClaw = self.childNode(withName: "CrabClaw") as! SKSpriteNode
		crabPhys = crabClaw.physicsBody!
        swordFishNode = self.childNode(withName: "SwordFish") as! SKSpriteNode
        swordFishPhys = swordFishNode.physicsBody!
		swordFish.body = swordFishNode
		cleaverNode = self.childNode(withName: "cleaver") as! SKSpriteNode
		cleaver.body = cleaverNode
		
        let topRight = CGPoint(x: -frame.origin.x, y: -frame.origin.y)
		let bottomRight = CGPoint(x: -frame.origin.x, y: frame.origin.y)
		
		backgroundNode.size = CGSize(width: self.frame.width, height: self.frame.height)
		backgroundNode.zPosition = -100
		backgroundNode.texture = SKTexture(image: UIImage(named: "beeech")!)
		self.addChild(backgroundNode)
		
		
		let right = SKNode()
		right.name = "right"
		right.physicsBody = SKPhysicsBody(edgeFrom: topRight, to: bottomRight)
		self.addChild(right)
		
		swordFishPhys.isDynamic = false
		cleaverNode.physicsBody?.isDynamic = false
		
		
		for x in enemies {
			x.body.zPosition = CGFloat(x.z)
			crabClaw.zPosition = CGFloat(enemy.z)
		}
		
		enemy.body.position.y += 300
		
		moveClawBackAction = SKAction.move(to: initialPosition, duration: 0.01)
		
        tapRec.addTarget(self, action:#selector(GameScene.tappedView(_:) ))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
		
		crabClaw.physicsBody?.categoryBitMask = clawCategory
		swordFishPhys.categoryBitMask = enemyCategory
		cleaverNode.physicsBody?.categoryBitMask = enemyCategory
		right.physicsBody?.categoryBitMask = rightCategory
		
		enemyP = CGPoint(x: swordFish.body.position.x, y: swordFishNode.position.y)
		
		swordFishPhys.contactTestBitMask = clawCategory|rightCategory
		cleaverNode.physicsBody?.contactTestBitMask = clawCategory|rightCategory
		
		enemy = enemies.randomElement()!
		
		
        // Starting the sworfish movement in here for now can move to a function later
//        let actualDuration = random(min: 10, max: 25)
//
//        let actionMove = SKAction.move(to: CGPoint(x: 640,y: 320), duration: TimeInterval(actualDuration))
//        let ahhhhhh = SKAction.move(by: swordFish.speed, duration: TimeInterval(actualDuration))
//        let actionMoveDone = SKAction.removeFromParent()
//        swordFishNode.run(SKAction.sequence([ahhhhhh, actionMoveDone]))

        
        
        
    }
	
    
    func didBegin(_ contact: SKPhysicsContact) {
        /* if contact.bodyb == (wallName) {
        swordfishNode.
         }
         */
		contactie = 1
		
		if contact.bodyA.categoryBitMask == clawCategory {
			enemy.body.physicsBody!.isDynamic = false
			let moveToActionS = SKAction.move(to: enemyP, duration: 0.01)
			enemy.body.run(moveToActionS)
			
		}
		if contact.bodyA.categoryBitMask == rightCategory {
			label = SKLabelNode(text: "You lost!")
			label.fontSize = 100.0
			label.position = CGPoint(x: 0, y: -35)
			self.addChild(label)
			cronched = 1
			enemy.body.physicsBody!.isDynamic = false
		}
    }
    
    @objc func tappedView(_ sender:UITapGestureRecognizer) {
		if cronched == 0 {
			
			crabClaw.texture = SKTexture(image: UIImage(named: "crabClawImageChomp")!)
			
			
			
			let crosshairPoint: CGPoint = CGPoint(x: 0, y: 0)
			
			var viewLocation = tapRec.location(in: view)
			viewLocation = crosshairPoint
			
			
			let moveToAction = SKAction.move(to: viewLocation, duration: 0.01)
			
			self.crabClaw.run(moveToAction)
			
			if CGPoint(x: crabClaw.position.x, y: crabClaw.position.y) == CGPoint(x: 0, y: 0) {
				self.crabClaw.run(moveClawBackAction)
				self.crabClaw.texture = SKTexture(image: UIImage(named: "crabClawImage")!)
			}
			cronched = 1
			if contactie == 1 {
				enemy.body.physicsBody!.isDynamic = false
			}
			runTimer()
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
		if contactie == 0 {
			enemyP = CGPoint(x: enemy.body.position.x, y: enemy.body.position.y)
			enemy.body.physicsBody!.isDynamic = true
			enemy.body.physicsBody!.velocity = enemy.speed
		}
		
	}
}
