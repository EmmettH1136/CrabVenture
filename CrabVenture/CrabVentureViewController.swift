//
//  CrabVentureViewController.swift
//  CrabVenture
//
//  Created by Michael Linker on 5/7/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit

class CrabVentureViewController: UIViewController {
    
    var image = UIImage(named: "Crab")

    //var imageView = UIImageView(image:)
    // :)
    @IBOutlet var allTiles: [UIImageView]!
    @IBOutlet weak var crabImageView: UIImageView!
    var crabFrame: CGRect = CGRect()
    var crabX: CGFloat = 0.0
    var crabY: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //right
    @IBAction func movecrab (_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
        self.crabImageView.frame.origin.x += 50}, completion: nil)
    }
    //left
    @IBAction func movecrableft (_sender: UIButton) {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                self.crabImageView.frame.origin.x -= 50}, completion: nil)

        }
	@IBAction func movecrabUP (_ sender: UIButton) {
		UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
		self.crabImageView.frame.origin.y -= 50}, completion: nil)
	}
	@IBAction func movecrabDown (_ sender: UIButton) {
		UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
		self.crabImageView.frame.origin.y += 50}, completion: nil)
	}
    }



