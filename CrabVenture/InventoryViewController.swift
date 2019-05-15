//
//  InventoryViewController.swift
//  CrabVenture
//
//  Created by Michael Linker on 5/13/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var CollectionView: UICollectionView!
    var numberOfCells = 2
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.delegate = self
       

    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }

}
