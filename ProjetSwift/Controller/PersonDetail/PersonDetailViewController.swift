//
//  PersonDetailViewController.swift
//  ProjetSwift
//
//  Created by user150862 on 4/2/19.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var balanceSheetTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var personExpenseTableViewController: PersonExpenseTableViewController!
    var personBalanceSheetTableViewController: PersonBalanceTableViewController!
    var person: Person? = nil
    var travel: Travel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let p = person else {
            fatalError("Unusual error")
        }
        guard let t = travel else {
            fatalError("Unusual error")
        }
        self.navBar.title = "\(p.name)'s detail"
        self.personExpenseTableViewController = PersonExpenseTableViewController(tableView: paymentTableView, person: p, travel: t)
        self.personBalanceSheetTableViewController = PersonBalanceTableViewController(tableView: balanceSheetTableView, person: p, travel: t, personExpenseTableViewController: self.personExpenseTableViewController)
    }
    
}
