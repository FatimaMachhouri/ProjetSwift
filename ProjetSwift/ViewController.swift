//
//  ViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 22/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var travelsNames : [String] = ["Allemagne", "Maroc", "Russie"]
    
    @IBOutlet weak var travelsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return self.travelsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.travelsTable.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath)
            as! TravelTableViewCell
        cell.travelNameLabel.text = self.travelsNames[indexPath.row]
        return cell
    }
    
}

