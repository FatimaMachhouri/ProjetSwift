//
//  TravelTableViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 26/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//


import UIKit

class TravelTableViewController: NSObject, UITableViewDataSource {
    var tableView: UITableView
    var travels: TravelSetViewModel
    let fetchResultController: TravelFetchResultController
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.fetchResultController = TravelFetchResultController(view: tableView)
        self.travels = TravelSetViewModel(data: self.fetchResultController.travelsFetched)
        super.init()
        self.tableView.dataSource = self
        self.travels.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as! TravelTableViewCell
        return configure(cell: cell, atIndexPath: indexPath)
    }
    
    private func configure(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        guard let travel = self.travels.get(travelAt: indexPath.row)
            else { return cell }
        (cell as! TravelTableViewCell).travelNameLabel?.text = travel.travelName
        // Hack to flip image to the right orientation
        if let cgImg = UIImage(data: travel.pic)?.cgImage {
            let pic = UIImage(cgImage: cgImg, scale: 1.0, orientation: .down)
            (cell as! TravelTableViewCell).imageViewer.image = pic
        }
        return cell
    }
    
}

extension TravelTableViewController: TravelSetViewModelDelegate {
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
