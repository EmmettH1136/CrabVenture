//
//  CrabVentureViewController.swift
//  CrabVenture
//
//  Created by Michael Linker on 5/7/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit

class CrabVentureViewController: UIViewController {
    
    @IBOutlet weak var mainCrab: UIImageView!
    @IBOutlet weak var swordFish: UIImageView!
    
    var image = UIImage(named: "Crab")
    
    var collision: UICollisionBehavior!
    
    //var imageView = UIImageView(image:)
    // :)
    @IBOutlet var allTiles: [UIImageView]!
    @IBOutlet weak var crabImageView: UIImageView!
    var crabFrame: CGRect = CGRect()
    var crabX: CGFloat = 0.0
    var crabY: CGFloat = 0.0
	var locationX = 0
	var locationY = -2
    
    override func viewDidLoad() {
        super.viewDidLoad()
      print("changed to View")
        
       
        
    }
    
    
    //right
    @IBAction func movecrab (_ sender: UIButton) {
		if locationX < 6 {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.x += 50}, completion: nil)
			locationX += 1
			crabImageView.image = UIImage(named: "Crab")
		}
    }
    //left
	@IBAction func movecrableft (_sender: UIButton) {
		if locationX > -6 {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.x -= 50}, completion: nil)
			locationX -= 1
			crabImageView.image = UIImage(named: "Crab")
		}
		
	}
	@IBAction func movecrabUP (_ sender: UIButton) {
		if locationY < 2 {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.y -= 50}, completion: nil)
			locationY += 1
			crabImageView.image = UIImage(named: "CrabUp")
		}
	}
	@IBAction func movecrabDown (_ sender: UIButton) {
		if locationY > -2 {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.y += 50}, completion: nil)
			locationY -= 1
			crabImageView.image = UIImage(named: "CrabUp")
		}
	}
    func ifTouching() {
        var touchingEnemy: Bool = false
        
        guard let r1 = mainCrab.superview?.convert(mainCrab.frame, to: nil) else { return }
        guard let r2 = swordFish.superview?.convert(swordFish.frame, to: nil) else { return }
        
        if r1.intersects(r2) { print("touching") }
    }
}



