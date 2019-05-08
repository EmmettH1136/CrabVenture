//
//  GameScene2.swift
//  CrabVenture
//
//  Created by Sean Pacursa on 5/2/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameScene2: SKScene {

	override func didMove(to view: SKView) {
		print("coolio")
	}
	
	func makePath() {
		// move this when the new scene is made
		let outTiles : [String] = []
		let tiles : [String] = []
		let poss : [String] = []
		let length = Int.random(in: 5...25)
	}
	
	override func update(_ currentTime: TimeInterval) {
	}
}
