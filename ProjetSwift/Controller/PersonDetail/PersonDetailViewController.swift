//
//  PersonDetailViewController.swift
//  ProjetSwift
//
//  Created by user150862 on 4/2/19.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {
    @IBOutlet weak var paymentTableView: UITableView!
    var  personExpenseTableViewController: PersonExpenseTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.personExpenseTableViewController = PersonExpenseTableViewController(tableView: paymentTableView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
