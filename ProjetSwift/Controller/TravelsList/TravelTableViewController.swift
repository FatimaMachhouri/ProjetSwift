//
//  TravelTableViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 26/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 3)
        self.layer.masksToBounds = true
    }
}

class TravelTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView
    var travels: TravelSetViewModel
    let fetchResultController: TravelFetchResultController
    var viewController: UIViewController
    
    init(tableView: UITableView, viewController: UIViewController) {
        self.tableView = tableView
        self.fetchResultController = TravelFetchResultController(view: tableView)
        self.travels = TravelSetViewModel(data: self.fetchResultController.travelsFetched)
        self.viewController = viewController
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as! TravelTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Edit", handler: ({ (rowAction, indexPath) in
            self.viewController.performSegue(withIdentifier: "updateTravelSegue", sender: self.tableView.cellForRow(at: indexPath))
        }))
        editButton.backgroundColor = UIColor.orange
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete", handler: ({ (rowAction, indexPath) in
            self.travels.delete(travelAt: indexPath.row)
        }))
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton, editButton]
    }
 
    private func configure(cell: TravelTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let travel = self.travels.get(travelAt: indexPath.row)
        cell.travelNameLabel?.text = travel.travelName
        cell.imageViewer.image = UIImage(data: travel.pic)
        cell.imageViewer.setRounded()
        return cell
    }
    
}
