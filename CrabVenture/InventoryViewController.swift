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
        while numberOfCells < 20 {
            let cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: IndexPath(row: 3, section: 1))
            cell.contentView.backgroundColor = .green
            cell.backgroundView?.backgroundColor = .brown
            CollectionView.addSubview(cell)
        }

    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }

}
