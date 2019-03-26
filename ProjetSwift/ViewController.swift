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
        self.tableViewController = TravelTableViewController(tableView: tableView)
    }
    
    @IBAction func unwindAfterNewTravelCreated(segue: UIStoryboardSegue) {
        if let newTravelController = segue.source as? AddTravelViewController {
            if let travelName = newTravelController.travelNameLabel, let picture = newTravelController.travelPic {
                self.tableViewController.travels.add(travel: Travel(name: travelName.text ?? " - ", pic: picture.pngData() ?? Data()))
            }
        }
    }

}

