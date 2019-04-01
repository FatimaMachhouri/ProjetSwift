//
//  AddExpenseTableViewCell.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 31/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class AddExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var buttonCheckBox: UIButton!
    @IBOutlet weak var amountTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
