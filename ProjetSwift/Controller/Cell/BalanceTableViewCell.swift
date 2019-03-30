//
//  BalanceTableViewCell.swift
//  ProjetSwift
//
//  Created by etud ig on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
