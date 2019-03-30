//
//  ExpenseViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tableViewController: ExpenseTableViewController!
    var travel: Travel? = nil
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        guard let t = travel else {
            fatalError("Unusual error")
        }
        self.tableViewController = ExpenseTableViewController(tableView: tableView, travel: t)
    }
    
}

