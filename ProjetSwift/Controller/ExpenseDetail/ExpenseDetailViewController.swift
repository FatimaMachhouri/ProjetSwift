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
    @IBOutlet weak var tableViewConcern: UITableView!
    @IBOutlet weak var expensePicture: UIImageView!
    @IBOutlet weak var expenseNameLabel: UILabel!
    @IBOutlet weak var expenseAmountLabel: UILabel!
    @IBOutlet weak var expenseDateLabel: UILabel!
    
    var expense: Expense? = nil
    var tableViewController: ExpenseDetailTableViewController!
    var tableViewControllerConcern: ExpenseDetailConcernTableViewController!

    override func viewDidLoad() {
        if let anExpense = self.expense {
            self.expenseNameLabel.text = anExpense.expenseName
            self.expenseAmountLabel.text = anExpense.amount.description
            self.expensePicture.image = UIImage(data: anExpense.expensePicture ?? Data())
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "dd/MM/yyyy"
            self.expenseDateLabel.text = dateFormatterPrint.string(from: anExpense.expenseDate ?? Date.init())
            
            self.tableViewController = ExpenseDetailTableViewController(tableView: tableView, expense: anExpense)
            self.tableViewControllerConcern = ExpenseDetailConcernTableViewController(tableView: tableViewConcern, expense: anExpense)
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
