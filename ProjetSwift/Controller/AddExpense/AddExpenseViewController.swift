//
//  AddExpenseViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 31/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit

class AddExpenseViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expenseName: UITextField!
    
    var tableViewController: AddExpenseTableViewController!
    var newExpense: Expense? = nil
    var travel: Travel? = nil
    
    @IBAction func precedentAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let t = travel else {
            fatalError("Unusal error")
        }
        self.tableViewController = AddExpenseTableViewController(tableView: self.tableView, travel: t)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text != "" {
                textField.resignFirstResponder()
                return true
            }
        }
        return false
    }
    
    
    // Mark: segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okNewExpenseSegue" {
            if let name = self.expenseName.text {
                self.newExpense = Expense(name: name)
                self.travel?.addToTravel_expenses(self.newExpense!)
            }
        }
    }
}
