//
//  ExpenseDetailTableViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class ExpenseDetailTableViewController: NSObject, UITableViewDataSource {
    var personsExpense: PersonsExpenseSetViewModel
    var tableView: UITableView
    
    init(tableView: UITableView, expense: Expense) {
        self.personsExpense = PersonsExpenseSetViewModel(expense: expense)
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
    }
    
    // Mark: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personsExpense.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsExpenseCell", for: indexPath) as! DetailExpenseTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    private func configure(cell: DetailExpenseTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let dataset = self.personsExpense.get(person_amount_at: indexPath.row)
        if let keys = self.personsExpense.get(person_amount_at: indexPath.row)?.keys {
            for person in keys {
                let amount = dataset?[person]
                cell.personNameLabel.text = person.personName
                cell.personAmountLabel.text = amount?.description
            }
        }
        return cell
    }
    
}
