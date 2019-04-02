//
//  TravelTableViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 26/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 3)
        self.layer.masksToBounds = true
    }
}

import UIKit

class TravelTableViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    var tableView: UITableView
    var travels: TravelSetViewModel
    let fetchResultController: TravelFetchResultController
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.fetchResultController = TravelFetchResultController(view: tableView)
        self.travels = TravelSetViewModel(data: self.fetchResultController.travelsFetched)
        super.init()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.travels.delegate = self
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as! TravelTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    // Old way of doing deleting
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.travels.delete(travelAt: indexPath.row)
        }
    }*/
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editButton = UITableViewRowAction(style: .normal, title: "Edit", handler: ({ (rowAction, indexPath) in
            print("edit")
        }))
        editButton.backgroundColor = UIColor.orange
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete", handler: ({ (rowAction, indexPath) in
            self.travels.delete(travelAt: indexPath.row)
        }))
        deleteButton.backgroundColor = UIColor.red
        return [deleteButton, editButton]
    }
 
    private func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let travel = self.travels.get(travelAt: indexPath.row)
        (cell as! TravelTableViewCell).travelNameLabel?.text = travel.travelName
        (cell as! TravelTableViewCell).imageViewer.image = UIImage(data: travel.pic)
        (cell as! TravelTableViewCell).imageViewer.setRounded()
        return cell
    }
    
}

extension TravelTableViewController: TravelSetViewModelDelegate {
    // MARK: TravelSetViewModelDelegate
    func dataSetChanged() {
        self.tableView.reloadData()
    }
    
    func travelAdded(at indexPath: IndexPath) {
        /*
         self.tableView.beginUpdates()
         self.tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.middle)
         self.tableView.endUpdates()
         */
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
}
