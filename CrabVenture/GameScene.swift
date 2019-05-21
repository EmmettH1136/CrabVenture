//
//  GameScene.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 4/30/19.
//  Copyright © 2019 John Heresy Hi2gh School. All rights reserved.
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
    var viewController: GameViewController!
    var gameVC: GameViewController?
    var crabClaw = SKSpriteNode()
	var crabPhys = SKPhysicsBody()
    var swordFishNode = SKSpriteNode()
	var swordFish = Enemy("SwordFish", 1, SKSpriteNode(), CGVector(dx: Int.random(in: 100...400), dy: 0), 0)
    var swordFishPhys = SKPhysicsBody()
	var cleaverNode = SKSpriteNode()
	var cleaver = Enemy("Cleaver", 1, SKSpriteNode(), CGVector(dx: Int.random(in: 400...800), dy: 0), 2)
	var cronched = 0
	var mantaRay = Enemy("MantaRay", 1, SKSpriteNode(), CGVector(dx: Int.random(in: 100...200), dy: 0), 2)
    let tapRec = UITapGestureRecognizer()
	var label = SKLabelNode()
	var backgroundNode = SKSpriteNode()
    var initialCrabPosition = CGPoint(x: 100, y: -400)
	
	var isSneakyTimerRunning = false
	var timer = Timer()
	var sneakyTimer = Timer()
	var sneakySeconds = 2
	var seconds = 0.5
	var isTimerRunning = false
	var initialPosition = CGPoint(x: 288.709, y: -300.153)
	var moveClawBackAction = SKAction()
	var enemyP = CGPoint()
	var enemies : [Enemy] = []
	var enemy = Enemy("boop", 0, SKSpriteNode(), CGVector(), 1)
	var electricBoogaloo = 0
	var hit = 0
	
	func runTimer() {
		timer = Timer.scheduledTimer(timeInterval: 0.5, target: self,   selector: (#selector(GameScene.updateTimer)), userInfo: nil, repeats: true)
		isTimerRunning = true
	}
	@objc func updateTimer() {
		if isTimerRunning {
			if seconds <= 0 {
				timer.invalidate()
				seconds = 0.5
				isTimerRunning = false
				self.crabClaw.run(moveClawBackAction)
				enemy.body.physicsBody?.isDynamic = true
				enemy.body.physicsBody?.velocity = enemy.speed
				electricBoogaloo = 1
			} else {
				seconds -= 0.5
			}
		}
	}
	func runSneakyTimer() {
		sneakyTimer = Timer.scheduledTimer(timeInterval: 0.25, target: self,   selector: (#selector(GameScene.updateSneakyTimer)), userInfo: nil, repeats: true)
		isSneakyTimerRunning = true
	}
	@objc func updateSneakyTimer() {
		if isSneakyTimerRunning {
			if seconds <= 0 {
				timer.invalidate()
				seconds = 2
				isTimerRunning = false
				enemy.body.physicsBody?.isDynamic = true
				enemy.body.physicsBody?.velocity = enemy.speed
			} else {
				seconds -= 0.25
				enemy.speed.dx += 100
			}
		}
	}
	

	var health = 1
    
    override func didMove(to view: SKView) {
        
        print(cronched)
        
        health = 1
        
		physicsWorld.contactDelegate = self
		
		enemies = [swordFish, cleaver, mantaRay]
		enemy = enemies.randomElement()!
		
        isTimerRunning = false
		electricBoogaloo = 0
		cronched = 0
		hit = 0
        crabClaw = self.childNode(withName: "CrabClaw") as! SKSpriteNode
		crabPhys = crabClaw.physicsBody!
        swordFishNode = self.childNode(withName: "SwordFish") as! SKSpriteNode
        swordFishPhys = swordFishNode.physicsBody!
		swordFish.body = swordFishNode
		cleaverNode = self.childNode(withName: "cleaver") as! SKSpriteNode
		cleaver.body = cleaverNode
		let mantaRayNode = self.childNode(withName: "MantaRay") as! SKSpriteNode
		mantaRay.body = mantaRayNode
		enemy.body.position = CGPoint(x: -932.162, y: 235.423)
		enemy.body.physicsBody?.isDynamic = true
		enemy.body.physicsBody?.velocity = enemy.speed
		if enemy.name == mantaRay.name {
			runSneakyTimer()
		}
		
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
		
		swordFishNode.physicsBody?.isDynamic = true
		cleaverNode.physicsBody?.isDynamic = true
		
		
		for x in enemies {
			x.body.zPosition = CGFloat(x.z)
			crabClaw.zPosition = CGFloat(enemy.z)
		}
		
		moveClawBackAction = SKAction.move(to: initialPosition, duration: 0.01)
		
        tapRec.addTarget(self, action:#selector(GameScene.tappedView(_:) ))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
		
		crabClaw.physicsBody?.categoryBitMask = clawCategory
		swordFishNode.physicsBody?.categoryBitMask = enemyCategory
		cleaverNode.physicsBody?.categoryBitMask = enemyCategory
		right.physicsBody?.categoryBitMask = rightCategory
		
		enemyP = CGPoint(x: swordFish.body.position.x, y: swordFishNode.position.y)
		
		swordFishNode.physicsBody?.contactTestBitMask = clawCategory|rightCategory
		cleaverNode.physicsBody?.contactTestBitMask = clawCategory|rightCategory
		
		
		
        // Starting the sworfish movement in here for now can move to a function later
//        let actualDuration = random(min: 10, max: 25)
//
//        let actionMove = SKAction.move(to: CGPoint(x: 640,y: 320), duration: TimeInterval(actualDuration))
//        let ahhhhhh = SKAction.move(by: swordFish.speed, duration: TimeInterval(actualDuration))
//        let actionMoveDone = SKAction.removeFromParent()
//        swordFishNode.run(SKAction.sequence([ahhhhhh, actionMoveDone]))

        
        
        
    }
	
    
    func didBegin(_ contact: SKPhysicsContact) {
		
		hit = 1
		
        let initialPosition = CGPoint(x: crabClaw.position.x, y: crabClaw.position.y)
        initialCrabPosition = initialPosition
        
        
		
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
			health -= 1
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
            
			
			let moveToAction = SKAction.move(to: viewLocation, duration: 0.15)
			
			enemy.body.physicsBody?.isDynamic = false
			
			self.crabClaw.run(moveToAction)
            
            cronched = 1
            let crabWhenGrabbedPosition = CGPoint(x: crabClaw.position.x, y: crabClaw.position.y)
			
            print(crabClaw.position)
			
			
            
            let moveClawBackAction = SKAction.move(to: initialCrabPosition, duration: 0.1)
            
            if crabClaw.position == crabWhenGrabbedPosition {
                self.crabClaw.run(moveClawBackAction)
                print("is at position")
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
			let vc = UIApplication.shared.keyWindow?.rootViewController as! GameViewController
				vc.gameOver()
			
		}
        
        if isTimerRunning == false {
                    //present second vc
                    //remove gamescene from ontop of vc
//            let vc = UIApplication.shared.keyWindow?.rootViewController as! GameViewController
//            vc.gameOver()
            
        }
		if hit == 1 && electricBoogaloo == 1 {
			let vc = UIApplication.shared.keyWindow?.rootViewController as! GameViewController
			vc.gameOver()
			electricBoogaloo = 0
		}
	}
}
////happy now xcode
