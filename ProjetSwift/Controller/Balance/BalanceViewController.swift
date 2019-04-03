//  BalanceViewController.swift
//  ProjetSwift
//
//  Created by etud ig on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var tableViewController: PersonTableViewController!
    var travel: Travel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let t = travel else {
            fatalError("Unusual error")
        }
        self.navBar.title = "Equilibre \(t.name)"
        self.tableViewController = PersonTableViewController(tableView: self.tableView, travel: t)
    }
    

    // MARK: - Navigation

    @IBAction func unwindAfterNewPersonCreated(segue: UIStoryboardSegue) {
        if let addPersonController = segue.source as? AddPersonViewController {
            if let person = addPersonController.newPerson {
                self.tableViewController.persons.add(person: person)
            }
        }
    }
    
    @IBAction func unwindAfterSeeingPersonDetail(_ unwindSegue: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? AddPersonViewController {
            destController.travel = self.travel
        }
        
        if let destController = segue.destination as? ExpenseViewController {
            destController.travel = self.travel
            destController.balanceViewController = self
        }
        
        if let destController = segue.destination as? PersonDetailViewController {
            if let cell = sender as? BalanceTableViewCell {
                if let name = cell.nameLabel.text {
                    destController.person = PersonDAO.search(forName: name)
                }
                destController.travel = self.travel
            }
        }
    }
    
}
