//
//  CrabVentureViewController.swift
//  CrabVenture
//
//  Created by Michael Linker on 5/7/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit

class CrabVentureViewController: UIViewController {
    @IBOutlet var allTiles: [UIImageView]!
    @IBOutlet weak var crabImageView: UIImageView!
    var crabFrame: CGRect = CGRect()
    var crabX: CGFloat = 0.0
    var crabY: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func swapPieces(imageView1: UIImageView, imageView2: UIImageView) {
        let tempImage = imageView2.image
        imageView2.image = imageView1.image
        imageView1.image = tempImage
        
    }
    @IBAction func whenRightArrowClicked(_ sender: Any) {
        crabFrame = crabImageView.frame
        crabY = crabFrame.midY
        crabX = crabFrame.midX
        crabFrame = CGRect(x: crabX + 100, y: crabY, width: crabFrame.width, height: crabFrame.height)
    }
    @IBAction func whenTopArrowClicked(_ sender: Any) {
        crabFrame = crabImageView.frame
        crabY = crabFrame.midY
        crabX = crabFrame.midX
        crabFrame = crabFrame.offsetBy(dx: 0, dy: 100)
        
    }
    @IBAction func whenBottomArrowClicked(_ sender: Any) {
        crabFrame = crabImageView.frame
        crabY = crabFrame.midY
        crabX = crabFrame.midX
        crabFrame = CGRect(x: crabX, y: crabY - 100, width: crabFrame.width, height: crabFrame.height)
    }
    @IBAction func whenLeftArrowClicked(_ sender: Any) {
        crabFrame = crabImageView.frame
        crabY = crabFrame.midY
        crabX = crabFrame.midX
        crabFrame = CGRect(x: crabX - 100, y: crabY, width: crabFrame.width, height: crabFrame.height)
    }
    

}
