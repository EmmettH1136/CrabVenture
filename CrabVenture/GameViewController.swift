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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var image = UIImage(named: \(crabgoeshere))
//
//        var imageView = UIImageView(image: \(crab))



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
            //call action whichever way button moves
//        @IBAction func movecrab (_ sender: UIButton) {
//            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
//            self.imageView.frame.origin.x += 50}, completion: nil)
//        }
    }
    
    func gameOver() {
        
        self.removeFromParent()
        performSegue(withIdentifier: "Segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
