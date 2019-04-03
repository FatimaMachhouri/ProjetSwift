//
//  AddPersonViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 23/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import UIKit

class AddPersonViewController: UIViewController, UITextFieldDelegate {
    var travel: Travel? = nil
    var newPerson: Person? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var stardDateTextField: UITextField!
    
    @IBAction func precedentAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let alertName = UIAlertController(title: "Erreur", message:"Impossible d'ajouter. Renseignez le nom de la personne à ajouter.", preferredStyle: .alert)
        alertName.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        
        if (identifier == "okNewPersonSegue") {
            guard self.nameTextField.hasText else {
                self.present(alertName, animated: true) {}
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okNewPersonSegue" {
            guard let personName = self.nameTextField.text else {
                return
            }

            let format = DateFormatter()
            format.dateFormat = "dd/MM/yyyy"
            let startDate: Date  = format.date(from: self.stardDateTextField.text!) ?? Date.init()
            
            let newParticipate = Participate(dateS: startDate)
            if let person = PersonDAO.search(forName: personName) {
                self.newPerson = person
            }
            else {
                self.newPerson = Person(name: personName)
            }
            self.travel?.addToTravel_participate(newParticipate)
            self.newPerson?.addToPerson_participate(newParticipate)
        }
    }
    
    // MARK: TextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
