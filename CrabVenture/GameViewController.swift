//
//  GameViewController.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 4/30/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

	let form1 = [-16, -26, -36, 16, 26, 36]
	let form2 = [-16, -24, -32, 32, 24, 16, -26, -36, -34, 36, 34, 26]
	let form3 = [-12, 12, -26, 26, -32, 32]
	let form4 = [-16, -14, -36, -34, 16, 14, 36, 34]
	let form5 = [-26,-24,-22,22,24,26]
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		let forms = [form1, form2, form3, form4, form5]
		let form = forms.randomElement()
		userDefaults.set(form, forKey: "form")
		userDefaults.set(-2, forKey: "locationY")
		userDefaults.set(0, forKey: "locationX")
		userDefaults.set(false, forKey: "eggY")
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
			
			
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }

    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		
		if let view = self.view as! SKView? {
			// Load the SKScene from 'GameScene.sks'
			if let scene = SKScene(fileNamed: "GameScene") {
				// Set the scale mode to scale to fit the window
				scene.scaleMode = .aspectFill
				
				// Present the scene
				view.presentScene(scene)
			}
			
			
			view.ignoresSiblingOrder = true
			
			view.showsFPS = true
			view.showsNodeCount = true
		}
	}
    
    func gameOver() {
        
//        self.removeFromParent()
//        self.dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
