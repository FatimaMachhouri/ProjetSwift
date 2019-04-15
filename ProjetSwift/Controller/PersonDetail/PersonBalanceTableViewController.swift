//
//  PersonBalanceTableViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 03/04/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

extension PersonBalanceTableViewController: PersonBalanceSheetDelegate {
    func lineDeleted(at indexPath: IndexPath) {
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
    }
}

class PersonBalanceTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView
    var personBalanceSheet: PersonBalanceSheetViewModel
    var personName: String
    
    init(tableView: UITableView, person: Person, travel: Travel, personExpenseTableViewController: PersonExpenseTableViewController) {
        self.tableView = tableView
        self.personBalanceSheet = PersonBalanceSheetViewModel(person: person, travel: travel, personExpenseTableViewController: personExpenseTableViewController)
        self.personName = person.name
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.personBalanceSheet.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.personBalanceSheet.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idMyBalanceCell", for: indexPath) as! PersonBalanceTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    func configure(cell: PersonBalanceTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        guard let balanceSheet = self.personBalanceSheet.get(exchange_at: indexPath.row) else {
            return cell
        }
        cell.personNameLabel.text = self.personName
        let amount = balanceSheet.1
        if amount > 0 {
            cell.amountLabel.text = "<-- " + amount.description + "€ --"
            cell.backgroundColor = UIColor(displayP3Red: 0, green: 255, blue: 0, alpha: 0.3)
        }
        else {
            cell.amountLabel.text = "-- " + amount.description + "€ -->"
            cell.backgroundColor = UIColor(displayP3Red: 255, green: 0, blue: 0, alpha: 0.3)
        }
        cell.concernedPersonNameLabel.text = balanceSheet.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let reimburseButton = UITableViewRowAction(style: .normal, title: "Rembourser", handler: ({ (rowAction, indexPath) in
            self.personBalanceSheet.reimburse(person_at: indexPath.row)
        }))
        reimburseButton.backgroundColor = UIColor.green
        return [reimburseButton]
    }
    
}
