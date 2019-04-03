//
//  TravelViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 03/04/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tableViewController: TravelTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableViewController = TravelTableViewController(tableView: tableView, viewController: self)
    }
    
    @IBAction func unwindAfterNewTravelCreated(segue: UIStoryboardSegue) {
    }
    
    @IBAction func unwindAfterTravelUpdate(_ unwindSegue: UIStoryboardSegue) {
        if let updateTravelController = unwindSegue.source as? UpdateTravelViewController {
            if let travel = updateTravelController.newTravel {
                if let travelName = updateTravelController.travelName.text {
                    travel.update(name: travelName, pic: updateTravelController.travelPic?.pngData() ?? Data())
                }
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
        else if let destController = segue.destination as? UpdateTravelViewController {
            if let cell = sender as? TravelTableViewCell {
                guard let indexPath = self.tableView.indexPath(for: cell) else {
                    return
                }
                destController.newTravel = self.tableViewController.travels.get(travelAt: indexPath.row)
            }
        }
    }

}
