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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

}
