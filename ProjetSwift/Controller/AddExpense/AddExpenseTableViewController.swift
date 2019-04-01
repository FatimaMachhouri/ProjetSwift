//
//  AddExpenseTableViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 01/04/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class AddExpenseTableViewController: NSObject, UITableViewDataSource, PersonSetViewModelDelegate {
    var persons: PersonSetViewModel
    var tableView: UITableView
    
    func dataSetChanged() {
        self.tableView.reloadData()
    }
    
    func personAdded(at indexPath: IndexPath) {
        //code
    }
    
    init(tableView: UITableView, travel: Travel) {
        self.persons = PersonSetViewModel(travel: travel)
        self.tableView = tableView
        super.init()
        self.tableView.dataSource = self
        self.persons.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addExpenseCell", for: indexPath) as! AddExpenseTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    private func configure(cell: AddExpenseTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        let person = self.persons.get(personAt: indexPath.row)
        cell.personNameLabel.text = person?.name
        return cell
    }
    
}
