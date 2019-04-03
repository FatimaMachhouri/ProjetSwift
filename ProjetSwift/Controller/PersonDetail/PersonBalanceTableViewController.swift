//
//  PersonBalanceTableViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 03/04/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class PersonBalanceTableViewController: NSObject, UITableViewDataSource {
    var tableView: UITableView
    var personBalanceSheet: PersonBalanceSheetViewModel
    var personName: String
    
    init(tableView: UITableView, person: Person, travel: Travel) {
        self.tableView = tableView
        self.personBalanceSheet = PersonBalanceSheetViewModel(person: person, travel: travel)
        self.personName = person.name
        super.init()
        self.tableView.dataSource = self
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
        fatalError("unusual error")
        }
        cell.personNameLabel.text = self.personName
        cell.amountLabel.text = balanceSheet.1.description
        cell.concernedPersonNameLabel.text = balanceSheet.0
        return cell
    }
    
    
}
