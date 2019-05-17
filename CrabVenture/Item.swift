//
//  Item.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 5/1/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import Foundation


class Item {
	var name : String
	var type : Int
	var desc : String = ""
	var inInvent : Bool
	
	init (_ name : String, _ type: Int, _ inInvent : Bool) {
		self.name = name
		self.type = type
        self.inInvent = inInvent
        switch type {
        case 0:
            desc = "A nice set of crab armor"
        case 1:
            desc = "A nice crab claw for you"
        default:
            desc = "Something else"
        }
        
        
		
	}
	
}

