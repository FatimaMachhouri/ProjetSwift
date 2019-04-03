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
        self.personExpenseTableViewController = PersonExpenseTableViewController(tableView: paymentTableView, person: p)
        self.personBalanceSheetTableViewController = PersonBalanceTableViewController(tableView: balanceSheetTableView, person: p, travel: t)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
