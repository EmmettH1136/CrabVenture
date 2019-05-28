//
//  Enemy.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 5/2/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Enemy {
	var name : String
	var speed : CGVector
	var health : Int
	var body : SKSpriteNode
	var z : Int
	var sneakChance : Int
	var sneakMount : CGFloat
	
	init (_ name : String, _ health : Int, _ body: SKSpriteNode, _ speed : CGVector, _ z: Int, _ sneak : Int, _ sneakM : CGFloat) {
		self.name = name
		self.speed = speed
		self.health = health
		self.body = body
		self.z = z
		sneakChance = sneak
		sneakMount = sneakM
		
	}
	
}
