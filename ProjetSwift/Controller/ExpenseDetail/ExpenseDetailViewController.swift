//
//  ExpenseDetailViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit
class ExpenseDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expensePicture: UIImageView!
    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    
    var expense: Expense? = nil
    var tableViewController: ExpenseDetailTableViewController!

    
    override func viewDidLoad() {
        if let anExpense = self.expense {
            self.expenseNameLabel.text = anExpense.expenseName
            self.expenseAmountLabel.text = anExpense.amount.description
            self.expensePicture.image = UIImage(data: anExpense.expensePicture ?? Data())
            guard let e = expense else {
                fatalError("Unusual error")
            }
            self.tableViewController = ExpenseDetailTableViewController(tableView: tableView, expense: e)
        }
        else {
            self.expenseNameLabel.text = ""
            self.expenseAmountLabel.text = ""
            self.expensePicture.image = nil
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
