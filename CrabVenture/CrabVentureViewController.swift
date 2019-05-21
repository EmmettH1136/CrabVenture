//
//  CrabVentureViewController.swift
//  CrabVenture
//
//  Created by Michael Linker on 5/7/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//
import SpriteKit
import GameplayKit
import UIKit

let userDefaults = UserDefaults.standard

class CrabVentureViewController: UIViewController {
    
    @IBOutlet weak var mainCrab: UIImageView!
    @IBOutlet weak var swordFish: UIImageView!
    @IBOutlet weak var eggtest: UIImageView!
    
    @IBOutlet weak var invent1: UIImageView!
	@IBOutlet weak var invent2: UIImageView!
	@IBOutlet weak var invent3: UIImageView!
	@IBOutlet weak var invent4: UIImageView!
    var inventory1 = UIImageView()
    var inventory2 = UIImageView()
    var inventory3 = UIImageView()
    var inventory4 = UIImageView()
    var spritesLocation: [CGRect] = []
	var egg = Item("egg", 2, false)
	
    var image = UIImage(named: "craeb")
    
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
	let form1 = [-16, -26, -36, 16, 26, 36]
	let form2 = [-16, -24, -32, 32, 24, 16, -26, -36, -34, 36, 34, 26]
	let form3 = [-12, 12, -26, 26, -32, 32]
	let form4 = [-16, -14, -36, -34, 16, 14, 36, 34]
	var beans = false
//	var bannedPoint1 = CGPoint(x: Int.random(in: -6...6), y: Int.random(in: -2...2))
//	var bannedPoin2 = CGPoint(x: Int.random(in: -6...6), y: Int.random(in: -2...2))
//	var bannedPoint3 = CGPoint(x: Int.random(in: -6...6), y: Int.random(in: -2...2))
	var bannedTile = UIImageView()
	var bannedTile2 = UIImageView()
	var bannedTile3 = UIImageView()
	var bannedTiles : [UIImageView] = []
    var touchingEnemy: Bool = false
    var touchingSprite: Bool = false
    
    var eggPickup: Bool = false
    var inventoryFull: Bool = false
    // important

    
    override func viewDidLoad() {
        super.viewDidLoad()
        inventory1 = invent1
        inventory2 = invent2
        inventory3 = invent3
        inventory4 = invent4
		var form : [Int] = []
		form = userDefaults.array(forKey: "form") as! [Int]
		locationX = 0
		locationY = -2
		
      	print("changed to View")
		location = CGPoint(x: locationX, y: locationY)
//		banned = [bannedPoint1, bannedPoin2, bannedPoint3]
		for tag in form {
			for tile in allTiles {
				if Int(tag) == tile.tag {
					bannedTiles.append(tile)
				}
			}
		}
		for x in bannedTiles {
			x.image = UIImage(named: "gravelpathtile")
			if abs(x.tag) < 20 {
				var point = Int()
				if x.tag < 0 {
					point = x.tag + 10
				} else {
					point = x.tag - 10
				}
				banned += [CGPoint(x: point, y: 2), CGPoint(x: point, y: 1), CGPoint(x: point - 1, y: 2), CGPoint(x: point - 1, y: 1), CGPoint(x: point + 1, y: 2), CGPoint(x: point + 1, y: 1)]
			} else if abs(x.tag) < 30 {
				var point = Int()
				if x.tag < 0 {
					point = x.tag + 20
				} else {
					point = x.tag - 20
				}
				banned += [CGPoint(x: point, y: 1), CGPoint(x: point, y: -1), CGPoint(x: point - 1, y: 1), CGPoint(x: point - 1, y: 0), CGPoint(x: point - 1, y: -1), CGPoint(x: point + 1, y: 1), CGPoint(x: point + 1, y: 0), CGPoint(x: point + 1, y: -1)]
			} else {
				var point = Int()
				if x.tag < 0 {
					point = x.tag + 30
				} else {
					point = x.tag - 30
				}
				banned += [CGPoint(x: point, y: -1), CGPoint(x: point, y: -2), CGPoint(x: point - 1, y: -2), CGPoint(x: point - 1, y: -1), CGPoint(x: point + 1, y: -2), CGPoint(x: point + 1, y: -1)]
			}
		}
		var randomFish = allTiles.randomElement()
		while randomFish!.image == UIImage(named: "gravelpathtile") {
			randomFish = allTiles.randomElement()
		}
		swordFish.frame.origin = randomFish!.frame.origin
		var randomEgg = allTiles.randomElement()
		while randomEgg!.image == UIImage(named: "gravelpathtile") {
			randomEgg = allTiles.randomElement()
		}
		eggtest.frame.origin = randomEgg!.frame.origin
        //vc
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		locationX = userDefaults.integer(forKey: "locationX")
		locationY = userDefaults.integer(forKey: "locationY")
		location = CGPoint(x: locationX, y: locationY)
		let originx = crabImageView.frame.origin.x
		let originy = crabImageView.frame.origin.y
		crabImageView.frame.origin = CGPoint(x: originx + CGFloat(locationX * 50), y: originy + CGFloat((locationY + 2) * -50) )
		let eggInvent = userDefaults.bool(forKey: "eggY")
		if eggInvent {
			eggtest.isHidden = true
			invent1.image = UIImage(named: "egg")
		}
	}
	
    enum WalkState {
        case idle
        case walking
    }
    private var walkState = WalkState.idle
    
    private func setupImageViewAnimation() {
        crabImageView.animationImages = [UIImage(named: "craeb"), UIImage(named: "craeb2")] as? [UIImage]
        crabImageView.animationDuration = 1
    }
    
    private func setupImageViewAnimationUp() {
        crabImageView.animationImages = [UIImage(named: "craebUp"), UIImage(named: "craeb2Up")] as? [UIImage]
        crabImageView.animationDuration = 1
    }
    
    private func connect() {
        crabImageView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.crabImageView.stopAnimating()
            
            // Updates UI
            self.toggleCastState()
        }
    }
    
    private func connectUp() {
        crabImageView.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.crabImageView.stopAnimating()
            
            // Updates UI
            self.toggleCastStateUp()
        }
    }
    
    private func disconnect() {
        toggleCastState()
    }
    
    private func disconnectUp() {
        toggleCastStateUp()
    }
    
    private func toggleCastState() {
        // Updates current Chromecast state
        walkState = walkState == .walking ? .idle : .walking
        
        // Updates `UIImageView` default image
        let image = walkState == .walking ? UIImage(named: "craeb2") : UIImage(named: "craeb")
        crabImageView.image = image
    }
    
    private func toggleCastStateUp() {
        // Updates current Chromecast state
        walkState = walkState == .walking ? .idle : .walking
        
        // Updates `UIImageView` default image
        let image = walkState == .walking ? UIImage(named: "craeb2Up") : UIImage(named: "craebUp")
        crabImageView.image = image
    }
    
    //right
    @IBAction func movecrab (_ sender: UIButton) {
		let newLocation = (CGPoint(x: locationX + 1, y: locationY))
        
        switch walkState {
        case .idle:
            disconnect()
        case .walking:
            connect()
        }
        
		for x in banned {
			if newLocation == x {
				noGo = true
			}
		}
		if locationX < 6 && noGo == false {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.x += 50}, completion: nil)
			locationX += 1
			crabImageView.image = UIImage(named: "craeb2")
		} else {
			noGo = false
		}
		userDefaults.set(locationX, forKey: "locationX")
    }
    //left
	@IBAction func movecrableft (_sender: UIButton) {
		let newLocation = (CGPoint(x: locationX - 1, y: locationY))
        
        switch walkState {
        case .idle:
            disconnect()
        case .walking:
            connect()
        }
        
        
		for x in banned {
			if newLocation == x {
				noGo = true
			}
		}
		if locationX > -6 && noGo == false {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.x -= 50}, completion: nil)
			locationX -= 1
			self.crabImageView.image = UIImage(named: "craeb2")
		} else {
			noGo = false
		}
		userDefaults.set(locationX, forKey: "locationX")
	}
	@IBAction func movecrabUP (_ sender: UIButton) {
		let newLocation = (CGPoint(x: locationX , y: locationY + 1))
        
        switch walkState {
        case .idle:
            disconnectUp()
        case .walking:
            connectUp()
        }
		for x in banned {
			if newLocation == x {
				noGo = true
			}
		}
		if locationY < 2 && noGo == false {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations:  {
			self.crabImageView.frame.origin.y -= 50}, completion: nil)
			locationY += 1
			crabImageView.image = UIImage(named: "craebUp2")
		} else {
			noGo = false
		}
		userDefaults.set(locationY, forKey: "locationY")
	}
	@IBAction func movecrabDown (_ sender: UIButton) {
		let newLocation = (CGPoint(x: locationX, y: locationY - 1))
        
        switch walkState {
        case .idle:
            disconnectUp()
        case .walking:
            connectUp()
        }
		for x in banned {
			if newLocation == x {
				noGo = true
			}
		}
		if locationY > -2 && noGo == false {
			UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
			self.crabImageView.frame.origin.y += 50}, completion: nil)
			locationY -= 1
            
            self.crabImageView.image = UIImage(named: "craebUp2")
			
		} else {
			noGo = false
		}
		userDefaults.set(locationY, forKey: "locationY")
	}
    
    @IBAction func checkIfContact (_ sender: UIButton) {

        guard let r1 = mainCrab.superview?.convert(mainCrab.frame, to: nil) else { return }
        guard let r2 = swordFish.superview?.convert(swordFish.frame, to: nil) else { return }
        guard let r3 = eggtest.superview?.convert(eggtest.frame, to: nil) else { return }
        spritesLocation += ([r1, r2, r3])

        if r1.intersects(r2) { touchingEnemy = true }
        if r1.intersects(r3) { touchingSprite = true }
       
        if touchingEnemy == true {
            print("touching enemy")
            
			beans = true
			performSegue(withIdentifier: "bingo", sender: Any?.self)
            
        }
        
        if touchingSprite == true && inventoryFull == false {
            print ("touching sprite")
            
            guard let crabLocation = mainCrab.superview?.convert(mainCrab.frame, to: nil) else { return }
            guard let eggLocation = eggtest.superview?.convert(eggtest.frame, to: nil) else { return }
           
            //func to pick up for diff items
            func eggPickUpNow() {
                invent1.image = UIImage(named: "egg")
                eggtest.isHidden = true
                let eggNewLocationAfterTouch = CGRect(x: -1, y: -1, width: 1, height: 1)
                eggtest.frame = eggNewLocationAfterTouch
                //isHidden only hides; still can interact even if hidden
                egg.inInvent = true
                userDefaults.set(egg.inInvent, forKey: "eggY")
            }
            //checks which item crab is touching
            if crabLocation.intersects(eggLocation) {eggPickup = true}
            
            //checks if inv slot is taken for specific item
            if eggPickup == true {
                if invent1.image == UIImage(named: "EmptySlot") {
                    eggPickUpNow()
                } else if invent2.image == UIImage(named: "EmptySlot") {
                    eggPickUpNow()
                } else if invent3.image == UIImage(named: "EmptySlot") {
                    eggPickUpNow()
                } else if invent4.image == UIImage(named: "EmptySlot") {
                    eggPickUpNow()
                }
                
            }
            touchingSprite = false
        }
        
        if invent1.image != UIImage(named: "EmptySlot") && invent2.image != UIImage(named: "EmptySlot") && invent3.image != UIImage(named: "EmptySlot") && invent4.image != UIImage(named: "EmptySlot") {
            inventoryFull = true
        }
    }
    func moveToNewInventory(sender: UITapGestureRecognizer) {
        let rectangle = CGRect(x: -4, y: 304, width: 900, height: 110)
        let stackView: UIStackView = UIStackView(frame: rectangle)
        view.addSubview(stackView)
            if invent1.frame.contains(sender.location(in: stackView)) {}else {
                if invent2.frame.contains(sender.location(in: stackView)) {}else {
                    if invent3.frame.contains(sender.location(in: stackView)) {}else {
                        if invent4.frame.contains(sender.location(in: stackView)) {}else {
                            print("here3")
                            performSegue(withIdentifier: "modalSegue", sender: sender)
                        }
                    }
                }
            }
        view.willRemoveSubview(stackView)
        stackView.removeFromSuperview()
    }
    @IBAction func whenTappedStackView(_ sender: UITapGestureRecognizer) {
        moveToNewInventory(sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if beans {
			let nvc = segue.destination as! GameViewController
		} else {
        	let nvc = segue.destination as! InventoryViewController
            nvc.invent1 = invent1
            nvc.invent2 = invent2
            nvc.invent3 = invent3
            nvc.invent4 = invent4
		}
    }
    
}





