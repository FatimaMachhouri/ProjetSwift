//  BalanceViewController.swift
//  ProjetSwift
//
//  Created by etud ig on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class BalanceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tableViewController: PersonTableViewController!
    var travel: Travel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let t = travel else {
            fatalError("Unusual error")
        }
        self.tableViewController = PersonTableViewController(tableView: self.tableView, travel: t)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindAfterNewPersonCreated(segue: UIStoryboardSegue) {
        if let addPersonController = segue.source as? AddPersonViewController {
            if let person = addPersonController.newPerson {
                self.tableViewController.persons.add(person: person)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? AddPersonViewController {
            destController.travel = self.travel
        }
        
        if let destController = segue.destination as? ExpenseViewController {
            destController.travel = self.travel
        }
        
        if let destController = segue.destination as? PersonDetailViewController {
            if let cell = sender as? BalanceTableViewCell {
                if let name = cell.nameLabel.text {
                    destController.person = PersonDAO.search(forName: name)
                }
            }
        }
    }
    
}
