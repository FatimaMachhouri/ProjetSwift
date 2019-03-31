//
//  AddPersonViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 23/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {
    var newPerson: Person?
    var newParticipate: Participate?
    var travel: Travel? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var stardDateTextField: UITextField!
    
    @IBAction func precedentAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "okNewPersonSegue" {
            let personName: String  = self.nameTextField.text!

            let format = DateFormatter()
            format.dateFormat = "dd/MM/yyyy"
            let startDate: Date  = format.date(from: self.stardDateTextField.text!) ?? Date.init()
            
            self.newParticipate = Participate(dateS: startDate)
            self.newPerson = Person(name: personName)
            self.travel?.addToTravel_participate(self.newParticipate!)
            newPerson?.addToPerson_participate(self.newParticipate!)
            
        }
    }
    
    // MARK: TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            if text != "" {
                textField.resignFirstResponder()
                return true
            }
        }
        return false
    }


}
