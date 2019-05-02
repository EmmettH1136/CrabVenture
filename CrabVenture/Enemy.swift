//
//  Enemy.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 5/2/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import Foundation
import UIKit

class Enemy {
	var name : String
	var speed : CGVector
	
	init (_ name : String, _ speed : CGVector) {
		self.name = name
		self.speed = speed
		
	}
}
