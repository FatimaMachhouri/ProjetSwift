//
//  ViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 22/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tableViewController: TravelTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableViewController = TravelTableViewController(tableView: tableView, viewController: self)
    }
    
    @IBAction func unwindAfterNewTravelCreated(segue: UIStoryboardSegue) {
        if let addTravelController = segue.source as? AddTravelViewController {
            if let travel = addTravelController.newTravel {
                self.tableViewController.travels.add(travel: travel)
            }
        }
    }
    
    @IBAction func unwindAfterTravelUpdate(_ unwindSegue: UIStoryboardSegue) {
        if let updateTravelController = unwindSegue.source as? UpdateTravelViewController {
            if let travel = updateTravelController.newTravel {
                travel.update(name: updateTravelController.travelName.text!, pic: updateTravelController.travelPic?.pngData() ?? Data())
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destController = segue.destination as? BalanceViewController {
            if let cell = sender as? TravelTableViewCell {
                guard let indexPath = self.tableView.indexPath(for: cell) else{
                    return
                }
                destController.travel = self.tableViewController.travels.get(travelAt: indexPath.row)
            }
        }
        if let destController = segue.destination as? UpdateTravelViewController {
            if let cell = sender as? TravelTableViewCell {
                guard let indexPath = self.tableView.indexPath(for: cell) else {
                    return
                }
                destController.newTravel = self.tableViewController.travels.get(travelAt: indexPath.row)
            }
        }
    }
}

