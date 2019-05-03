//
//  Tile.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 5/2/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import Foundation

class Tile {
	var position : Int
	var left : String
	var right : String
	var up : String
	var down : String
	var name : String
	var used : Bool
	var building : Bool
	var fOrL : Bool
	var list = [String]()
	init(_ pos : Int, lef : String, righ : String, u : String, dow : String, _ nam : String, _ e : Bool) {
		self.position = pos
		left = lef
		right = righ
		up = u
		down = dow
		name = nam
		used = e
		building = e
		fOrL = e
	}
}
