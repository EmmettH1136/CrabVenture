//
//  InventoryViewController.swift
//  CrabVenture
//
//  Created by Michael Linker on 5/13/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView3: UITableView!
    var invent1: UIImageView = UIImageView()
    var invent2: UIImageView = UIImageView()
    var invent3: UIImageView = UIImageView()
    var invent4: UIImageView = UIImageView()
    var count = 0
    var count2 = 0
    var firstCell = UITableViewCell()
    var secondCell = UITableViewCell()
    var cell1 = ""
    var cell2 = ""
    var cell3 = ""
    var cell4 = ""
    var cell5 = ""
    var cell6 = ""
    var cell7 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        tableView1.delegate = self
        tableView3.delegate = self
        tableView1.dataSource = self
        tableView3.dataSource = self
        UIImage(named: "egg")?.accessibilityIdentifier = "egg"
        UIImage(named: "craebIRONClawJustClaw")?.accessibilityIdentifier = "craebIRONClawJustClaw"
        cell1 = userDefaults.string(forKey: "cell1o") ?? "egg"
        print(cell1)
        cell2 = userDefaults.string(forKey: "cell2o") ?? "egg"
        cell3 = userDefaults.string(forKey: "cell3o") ?? "egg"
        cell4 = userDefaults.string(forKey: "cell4o") ?? "egg"
        cell5 = userDefaults.string(forKey: "cell5o") ?? "egg"
        cell6 = userDefaults.string(forKey: "cell6o") ?? "egg"
        cell7 = userDefaults.string(forKey: "cell7o") ?? "egg"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
        return 4
        }else {
            return 7
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch count2 {
        case 0:
            firstCell = tableView.visibleCells[indexPath.row]
            count2 = 1
        default:
            secondCell = tableView.visibleCells[indexPath.row]
            count2 = 0
            swapPieces(imageView1: firstCell.imageView!, imageView2: secondCell.imageView!)
        }
        invent1 = tableView1.visibleCells[0].imageView!
        invent2 = tableView1.visibleCells[1].imageView!
        invent3 = tableView1.visibleCells[2].imageView!
        invent4 = tableView1.visibleCells[3].imageView!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            switch count {
            case 0:
                print("I AM HERE")
                cell.imageView?.image = invent1.image
                
            case 1:
                cell.imageView?.image = invent2.image
                
            case 2:
                cell.imageView?.image = invent3.image
                
            case 3:
                cell.imageView?.image = invent4.image
            default:
                print(count)
                print("strognngngng")
                _ = UITableViewCell()
            }
            count += 1
            return cell

            }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") {
                print("there is a cell1")
                switch count {
                case 4:
                    cell.imageView?.image = UIImage(named: cell1)
                    print("iggggggy")
                case 5:
                    cell.imageView?.image = UIImage(named: cell2)
                case 6:
                    cell.imageView?.image = UIImage(named: cell3)
                case 7:
                    cell.imageView?.image = UIImage(named: cell4)
                case 8:
                    cell.imageView?.image = UIImage(named: cell5)
                case 9:
                    cell.imageView?.image = UIImage(named: cell6)
                case 10:
                    cell.imageView?.image = UIImage(named: cell7)
                    
                default:
                    print("h")
                    _ = UITableViewCell()
                }
                count += 1
                return cell
            }else {
            
                return UITableViewCell()
            }
        }

    }
    func swapPieces(imageView1: UIImageView, imageView2: UIImageView) {
        let tempImage = imageView2.image
        let otherImage = imageView1.image
        imageView2.image = otherImage
        imageView1.image = tempImage
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! CrabVentureViewController
        nvc.inventory1 = invent1
        nvc.inventory2 = invent2
        nvc.inventory3 = invent3
        nvc.inventory4 = invent4
        userDefaults.set(tableView3.visibleCells[0].imageView!.image?.accessibilityIdentifier, forKey: "cell1o")
        userDefaults.set(tableView3.visibleCells[1].imageView!.image?.accessibilityIdentifier, forKey: "cell2o")
        userDefaults.set(tableView3.visibleCells[2].imageView!.image?.accessibilityIdentifier, forKey: "cell3o")
        userDefaults.set(tableView3.visibleCells[3].imageView!.image?.accessibilityIdentifier, forKey: "cell4o")
        userDefaults.set(tableView3.visibleCells[4].imageView!.image?.accessibilityIdentifier, forKey: "cell5o")
        userDefaults.set(tableView3.visibleCells[5].imageView!.image?.accessibilityIdentifier, forKey: "cell6o")
        userDefaults.set(tableView3.visibleCells[6].imageView!.image?.accessibilityIdentifier, forKey: "cell7o")
        print(userDefaults.string(forKey: "cell1o")
)
    }
}
