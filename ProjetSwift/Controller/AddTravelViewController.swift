//
//  AddTravelController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 22/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit

class AddTravelViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var travelNameLabel: UITextField!
    @IBOutlet weak var personNameLabel: UITextField!
    
    @IBAction func precedentAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
