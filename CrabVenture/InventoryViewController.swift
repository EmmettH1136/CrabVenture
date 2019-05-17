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
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var tableView3: UITableView!
    var invent1: UIImageView = UIImageView()
    var invent2: UIImageView = UIImageView()
    var invent3: UIImageView = UIImageView()
    var invent4: UIImageView = UIImageView()
    var count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.delegate = self
        tableView2.delegate = self
        tableView3.delegate = self
        tableView1.dataSource = self
        tableView2.dataSource = self
        tableView3.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1 {
        return 4
        }else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            switch count {
            case 0:
                cell.imageView?.image = invent1.image
            case 1:
                cell.imageView?.image = invent2.image
            case 2:
                cell.imageView?.image = invent3.image
            case 3:
                cell.imageView?.image = invent4.image
            default:
                _ = UITableViewCell()
            }
            count += 1
                return cell
            }else {
            
                return UITableViewCell()
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nvc = segue.destination as! CrabVentureViewController
        nvc.inventory1 = invent1
        nvc.inventory2 = invent2
        nvc.inventory3 = invent3
        nvc.inventory4 = invent4
    }
}