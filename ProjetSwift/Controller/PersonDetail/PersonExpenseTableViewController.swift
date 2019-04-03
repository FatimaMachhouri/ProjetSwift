//
//  PersonExpenseTableViewController.swift
//  ProjetSwift
//
//  Created by user150862 on 4/2/19.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class PersonExpenseTableViewController: NSObject, UITableViewDataSource {
    var tableView: UITableView
    var personExpenses: PersonExpenseSetViewModel
    
    init(tableView: UITableView, person: Person) {
        self.tableView = tableView
        self.personExpenses = PersonExpenseSetViewModel(person: person)
        super.init()
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personExpenses.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idMyPaymentCell", for: indexPath) as! PersonExpenseTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    func configure(cell: PersonExpenseTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let personExpense = self.personExpenses.get(expense_at: indexPath.row) else {
            return cell
        }
        for (name, amount) in personExpense {
            cell.expenseNameLabel.text = name
            cell.expenseAmountLabel.text = amount.description
        }
        return cell
    }

}
