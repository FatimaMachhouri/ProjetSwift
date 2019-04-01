//
//  ExpenseViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit

class ExpenseTableViewController: NSObject, UITableViewDataSource, ExpenseSetViewModelDelegate {
    var expenses: ExpenseSetViewModel
    var tableView: UITableView

    init(tableView: UITableView, travel: Travel) {
        self.expenses = ExpenseSetViewModel(travel: travel)
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
        self.expenses.delegate = self
    }
    
    func dataSetChanged() {
        self.tableView.reloadData()
    }
    
    func expenseAdded(at indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.middle)
        self.tableView.endUpdates()
    }
    
    func expenseDeleted(at indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.middle)
        self.tableView.endUpdates()
    }
    
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsTravelCell", for: indexPath) as! ExpenseTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.expenses.delete(expenseAt: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func configure(cell: ExpenseTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let expense = self.expenses.get(expenseAt: indexPath.row)
        cell.expenseNameLabel.text = expense?.expenseName
        cell.expenseAmountLabel.text = expense?.amount.description
        return cell
    }
    
}
