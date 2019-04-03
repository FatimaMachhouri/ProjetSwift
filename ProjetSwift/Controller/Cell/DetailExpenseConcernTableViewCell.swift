//
//  DetailExpenseConcernTableViewCell.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 02/04/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class DetailExpenseConcernTableViewCell: UITableViewCell {    
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var amountConcernLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
