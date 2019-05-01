//
//  GameScene.swift
//  CrabVenture
//
//  Created by Emmett Hasley on 4/30/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        var crabClaw = SKSpriteNode()
        crabClaw = self.childNode(withName: "SKSpriteNode") as! SKSpriteNode
        
        let tapRec = UITapGestureRecognizer()
        
        tapRec.addTarget(self, action:#selector(GameScene.tappedView(_:) ))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
    }
    
    
    
    @objc func tappedView(_ sender:UITapGestureRecognizer) {
        
        let crosshairPoint: CGPoint = CGPoint(x: 0, y: 0)
        
        //let viewLocation = 
        
    }
    
    func removeAllGestures(){
        
        for gesture in (self.view?.gestureRecognizers)! {
            
            self.view?.removeGestureRecognizer(gesture)
            
        }
        // for scene transitions
    }
}
