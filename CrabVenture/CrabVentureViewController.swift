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
	@IBOutlet weak var invent1: UIImageView!
	@IBOutlet weak var invent2: UIImageView!
	@IBOutlet weak var invent3: UIImageView!
	@IBOutlet weak var invent4: UIImageView!
	
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
	var location = CGPoint(x: 0, y: 0)
	var banned : [CGPoint] = []
	var noGo = false
//	var bannedPoint1 = CGPoint(x: Int.random(in: -6...6), y: Int.random(in: -2...2))
//	var bannedPoin2 = CGPoint(x: Int.random(in: -6...6), y: Int.random(in: -2...2))
//	var bannedPoint3 = CGPoint(x: Int.random(in: -6...6), y: Int.random(in: -2...2))
	var bannedTile = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
      	print("changed to View")
		location = CGPoint(x: locationX, y :locationY)
//		banned = [bannedPoint1, bannedPoin2, bannedPoint3]
		bannedTile = allTiles.randomElement()!
		bannedTile.image = UIImage(named: "gravelpathtile")
		if abs(bannedTile.tag) < 20 {
			var point = Int()
			if bannedTile.tag < 0 {
				point = bannedTile.tag + 10
			} else {
				point = bannedTile.tag - 10
			}
			banned = [CGPoint(x: point, y: 2), CGPoint(x: point, y: 1), CGPoint(x: point - 1, y: 2), CGPoint(x: point - 1, y: 1), CGPoint(x: point + 1, y: 2), CGPoint(x: point + 1, y: 1)]
		} else if abs(bannedTile.tag) < 30 {
			var point = Int()
			if bannedTile.tag < 0 {
				point = bannedTile.tag + 20
			} else {
				point = bannedTile.tag - 20
			}
			banned = [CGPoint(x: point, y: 1), CGPoint(x: point, y: -1), CGPoint(x: point - 1, y: 1), CGPoint(x: point - 1, y: 0), CGPoint(x: point - 1, y: -1), CGPoint(x: point + 1, y: 1), CGPoint(x: point + 1, y: 0), CGPoint(x: point + 1, y: -1)]
		} else {
			var point = Int()
			if bannedTile.tag < 0 {
				point = bannedTile.tag + 30
			} else {
				point = bannedTile.tag - 30
			}
			banned = [CGPoint(x: point, y: -1), CGPoint(x: point, y: -2), CGPoint(x: point - 1, y: -2), CGPoint(x: point - 1, y: -1), CGPoint(x: point + 1, y: -2), CGPoint(x: point + 1, y: -1)]
		}
    }
    
    
    //right
    @IBAction func movecrab (_ sender: UIButton) {
		let newLocation = (CGPoint(x: locationX + 1, y: locationY))
		for x in banned {
			if newLocation == x {
				noGo = true
			}
		}
		if locationX < 6 && noGo == false {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.x += 50}, completion: nil)
			locationX += 1
			crabImageView.image = UIImage(named: "Crab")
		} else {
			noGo = false
		}
    }
    //left
	@IBAction func movecrableft (_sender: UIButton) {
		let newLocation = (CGPoint(x: locationX - 1, y: locationY))
		for x in banned {
			if newLocation == x {
				noGo = true
			}
		}
		if locationX > -6 && noGo == false {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.x -= 50}, completion: nil)
			locationX -= 1
			crabImageView.image = UIImage(named: "Crab")
		} else {
			noGo = false
		}
		
	}
	@IBAction func movecrabUP (_ sender: UIButton) {
		let newLocation = (CGPoint(x: locationX , y: locationY + 1))
		for x in banned {
			if newLocation == x {
				noGo = true
			}
		}
		if locationY < 2 && noGo == false {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.y -= 50}, completion: nil)
			locationY += 1
			crabImageView.image = UIImage(named: "CrabUp")
		} else {
			noGo = false
		}
	}
	@IBAction func movecrabDown (_ sender: UIButton) {
		let newLocation = (CGPoint(x: locationX, y: locationY - 1))
		for x in banned {
			if newLocation == x {
				noGo = true
			}
		}
		if locationY > -2 && noGo == false {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.y += 50}, completion: nil)
			locationY -= 1
			crabImageView.image = UIImage(named: "CrabUp")
		} else {
			noGo = false
		}
	}

    func ifTouching() {
       
        var touchingEnemy: Bool = false
        
        guard let r1 = mainCrab.superview?.convert(mainCrab.frame, to: nil) else { return }
        guard let r2 = swordFish.superview?.convert(swordFish.frame, to: nil) else { return }
        
        if r1.intersects(r2) { touchingEnemy = true }
        
        if touchingEnemy == true {
            print("touching")
        }
        return
    }
}



