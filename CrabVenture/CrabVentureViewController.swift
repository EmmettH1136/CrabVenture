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
    @IBOutlet weak var ironClaw: UIImageView!
    
    
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
    var ironClawInInvent = Item("ironClaw", 1, false)
    var hasIronClaw = false
    var image = UIImage(named: "craeb")
    var setCrabImageToIron: Bool = false
    
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
    var ironClawPickup: Bool = false
    
    var inventoryFull: Bool = false
    // important
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        invent1.image = inventory1.image
        invent2.image = inventory2.image
        invent3.image = inventory3.image
        invent4.image = inventory4.image
        invent1.image == nil ? invent1.image = UIImage(named: "EmptySlot"):nil
        invent2.image == nil ? invent2.image = UIImage(named: "EmptySlot"):nil
        invent3.image == nil ? invent3.image = UIImage(named: "EmptySlot"):nil
        invent4.image == nil ? invent4.image = UIImage(named: "EmptySlot"):nil
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
		var randomClaw = allTiles.randomElement()
		while randomClaw!.image == UIImage(named: "gravelpathtile") {
			randomClaw = allTiles.randomElement()
		}
		eggtest.frame.origin = randomEgg!.frame.origin
		ironClaw.frame.origin = randomClaw!.frame.origin
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
        //        if eggInvent {
        //            eggtest.isHidden = true
        //            invent1.image = UIImage(named: "egg")
        //        }
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
        
        if setCrabImageToIron == false {
            let image = walkState == .walking ? UIImage(named: "craeb2") : UIImage(named: "craeb")
            crabImageView.image = image
        }
        else {
            let image = walkState == .walking ? UIImage(named: "craebIRONClaw2") : UIImage(named: "craebIRONClaw")
            crabImageView.image = image
        }
        
    }
    
    private func toggleCastStateUp() {
        // Updates current Chromecast state
        walkState = walkState == .walking ? .idle : .walking
        
        // Updates `UIImageView` default image
        
        if setCrabImageToIron == false {
            let image = walkState == .walking ? UIImage(named: "craeb2Up") : UIImage(named: "craebUp")
            crabImageView.image = image
        }
        else {
            let image = walkState == .walking ? UIImage(named: "craebIRONClaw2Up") : UIImage(named: "craebIRONClawUp")
            crabImageView.image = image
        }
        
    }
    
    //right
    @IBAction func movecrab (_ sender: UIButton) {
        
        if ironClawInInvent.inInvent == true {
            setCrabImageToIron = true
        }
        
        
        
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
            if setCrabImageToIron == false {
                self.crabImageView.image = UIImage(named: "craeb2")
            }
            else {
                self.crabImageView.image = UIImage(named: "craebIRONClaw2")
            }
        } else {
            noGo = false
        }
        userDefaults.set(locationX, forKey: "locationX")
        checkIfContact()
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
            if setCrabImageToIron == false {
                self.crabImageView.image = UIImage(named: "craeb2")
            }
            else {
                self.crabImageView.image = UIImage(named: "craebIRONClaw2")
            }
        } else {
            noGo = false
        }
        userDefaults.set(locationX, forKey: "locationX")
        checkIfContact()
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
            if setCrabImageToIron == false {
                self.crabImageView.image = UIImage(named: "craebUp2")
            }
            else {
                self.crabImageView.image = UIImage(named: "craebIRONClaw2Up")
            }
        } else {
            noGo = false
        }
        userDefaults.set(locationY, forKey: "locationY")
        checkIfContact()
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
            
            if setCrabImageToIron == false {
                self.crabImageView.image = UIImage(named: "craebUp2")
            }
            else {
                self.crabImageView.image = UIImage(named: "craebIRONClaw2Up")
            }
        } else {
            noGo = false
        }
        userDefaults.set(locationY, forKey: "locationY")
        checkIfContact()
    }
    
    func checkIfContact() {
        let mainCrabContact = mainCrab.superview?.convert(mainCrab.frame, to: nil)
        let swordFishContact = swordFish.superview?.convert(swordFish.frame, to: nil)
        let eggContact = eggtest.superview?.convert(eggtest.frame, to: nil)
        let ironClawItemContact = ironClaw.superview?.convert(ironClaw.frame, to: nil)
        
        if mainCrabContact!.intersects(swordFishContact!) { touchingEnemy = true }
        
        if mainCrabContact!.intersects(eggContact!) { eggPickup = true }
        if mainCrabContact!.intersects(ironClawItemContact!) { ironClawPickup = true } 
        
        
        
        print(touchingEnemy)
        print(eggPickup)
        print(ironClawPickup)
        
        
        if touchingEnemy == true {
            print("touching enemy")

            beans = true
            performSegue(withIdentifier: "bingo", sender: Any?.self)

        }

            
            //checks if inv slot is taken for specific item
            print("HIIII")
            if eggPickup == true {
                print("HEEEELLLLLLLOOOO")
                if invent1.image == UIImage(named: "EmptySlot") {
                    invent1.image = UIImage(named: "egg")
                    eggtest.isHidden = true
                    let eggNewLocationAfterTouch = CGRect(x: -1000, y: -1000, width: 1, height: 1)
                    eggtest.frame = eggNewLocationAfterTouch
                    //isHidden only hides; still can interact even if hidden
                    egg.inInvent = true
                    userDefaults.set(egg.inInvent, forKey: "eggY")
                eggPickup = false
            } else if invent2.image == UIImage(named: "EmptySlot") {
                invent2.image = UIImage(named: "egg")
                eggtest.isHidden = true
                let eggNewLocationAfterTouch = CGRect(x: -1, y: -1, width: 1, height: 1)
                eggtest.frame = eggNewLocationAfterTouch
                //isHidden only hides; still can interact even if hidden
                egg.inInvent = true
                userDefaults.set(egg.inInvent, forKey: "eggY")
                eggPickup = false
            } else if invent3.image == UIImage(named: "EmptySlot") {
                invent3.image = UIImage(named: "egg")
                eggtest.isHidden = true
                let eggNewLocationAfterTouch = CGRect(x: -1, y: -1, width: 1, height: 1)
                eggtest.frame = eggNewLocationAfterTouch
                //isHidden only hides; still can interact even if hidden
                egg.inInvent = true
                userDefaults.set(egg.inInvent, forKey: "eggY")
                eggPickup = false
            } else if invent4.image == UIImage(named: "EmptySlot") {
                invent4.image = UIImage(named: "egg")
                eggtest.isHidden = true
                let eggNewLocationAfterTouch = CGRect(x: -1, y: -1, width: 1, height: 1)
                eggtest.frame = eggNewLocationAfterTouch
                //isHidden only hides; still can interact even if hidden
                egg.inInvent = true
                userDefaults.set(egg.inInvent, forKey: "eggY")
                eggPickup = false
            }

        }
        //when egg first picks both up
        if ironClawPickup == true {
            
            
            if invent1.image == UIImage(named: "EmptySlot") {
                invent1.image = UIImage(named: "craebIRONClawJustClawInventoryPreview")
                ironClaw.isHidden = true
                let ironClawNewLocation = CGRect(x: -1, y: -1, width: -1, height: -1)
                ironClaw.frame = ironClawNewLocation
                ironClawInInvent.inInvent = true
                userDefaults.set(ironClawInInvent.inInvent, forKey: "ironClawY")
                ironClawPickup = false
            }   else if invent2.image == UIImage(named: "EmptySlot") {
                invent2.image = UIImage(named: "craebIRONClawJustClawInventoryPreview")
                ironClaw.isHidden = true
                let ironClawNewLocation = CGRect(x: -1, y: -1, width: -1, height: -1)
                ironClaw.frame = ironClawNewLocation
                ironClawInInvent.inInvent = true
                userDefaults.set(ironClawInInvent.inInvent, forKey: "ironClawY")
            } else if invent3.image == UIImage(named: "EmptySlot") {
                invent3.image = UIImage(named: "craebIRONClawJustClawInventoryPreview")
                ironClaw.isHidden = true
                let ironClawNewLocation = CGRect(x: -1, y: -1, width: -1, height: -1)
                ironClaw.frame = ironClawNewLocation
                ironClawInInvent.inInvent = true
                userDefaults.set(ironClawInInvent.inInvent, forKey: "ironClawY")
            } else if invent4.image == UIImage(named: "EmptySlot") {
                invent4.image = UIImage(named: "craebIRONClawJustClawInventoryPreview")
                ironClaw.isHidden = true
                let ironClawNewLocation = CGRect(x: -1, y: -1, width: -1, height: -1)
                ironClaw.frame = ironClawNewLocation
                ironClawInInvent.inInvent = true
                userDefaults.set(ironClawInInvent.inInvent, forKey: "ironClawY")
            }
            ironClawPickup = false
        }
        print(ironClawPickup)

        //checks if inventory is full
        if invent1.image != UIImage(named: "EmptySlot") && invent2.image != UIImage(named: "EmptySlot") && invent3.image != UIImage(named: "EmptySlot") && invent4.image != UIImage(named: "EmptySlot") {
            inventoryFull = true
            }
        return
    }
    //end
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



