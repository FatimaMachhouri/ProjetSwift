//
//  PersonTableViewController.swift
//  ProjetSwift
//
//  Created by etud ig on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class PersonTableViewController: NSObject, UITableViewDataSource, PersonSetViewModelDelegate {
    var persons: PersonSetViewModel
    var tableView: UITableView
    
    init(tableView: UITableView, travel: Travel) {
        self.persons = PersonSetViewModel(travel: travel)
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
        self.persons.delegate = self
    }
    
    func dataSetChanged() {
        self.tableView.reloadData()
    }
    
    func personAdded(at indexPath: IndexPath) {
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "balanceCell", for: indexPath) as! BalanceTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    private func configure(cell: BalanceTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let person = self.persons.get(personAt: indexPath.row)
        cell.nameLabel.text = person?.name
        return cell
    }
    
}
