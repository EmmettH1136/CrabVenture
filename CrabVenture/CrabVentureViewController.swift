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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func swapPieces(imageView1: UIImageView, imageView2: UIImageView) {
        let tempImage = imageView2.image
        imageView2.image = imageView1.image
        imageView1.image = tempImage
        
    }
    @IBAction func whenRightArrowClicked(_ sender: Any) {
        crabImageView.frame = CGRect(x:crabImageView.frame.midX, y: crabImageView.frame.midY + 100, width: crabImageView.frame.width, height: crabImageView.frame.height)
    }
    @IBAction func whenTopArrowClicked(_ sender: Any) {
    }
    @IBAction func whenBottomArrowClicked(_ sender: Any) {
    }
    @IBAction func whenLeftArrowClicked(_ sender: Any) {
    }
    
    @IBAction func movecrab (_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
        self.imageView.frame.origin.x += 50}, completion: nil)
        }
    }

