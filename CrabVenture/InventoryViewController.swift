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
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
                return cell
            }else {
                return UITableViewCell()
            }
    }
}
