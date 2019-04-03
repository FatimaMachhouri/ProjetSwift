//
//  AddTravelController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 22/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit

class AddTravelViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource {
    @IBOutlet weak var travelNameLabel: UITextField!
    @IBOutlet weak var personNameLabel: UITextField!
    @IBOutlet weak var personTableView: UITableView!
    
    var travelPic: UIImage? = nil
    var persons: [String] = []
    var newTravel: Travel? = nil
    
    @IBAction func loadPhotoAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            travelPic = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPersonAction(_ sender: Any) {
        guard let txt = self.personNameLabel.text else { return }
        self.persons.append(txt)
        self.personNameLabel.text = nil
        addPersonToTableView(at: IndexPath(row: self.persons.count-1, section: 0))
    }
    
    @IBAction func precedentAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addPersonToTableView(at indexPath: IndexPath) {
        self.personTableView.beginUpdates()
        self.personTableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.middle)
        self.personTableView.endUpdates()
    }
    
    func deletePersonFromTableView(at indexPath: IndexPath) {
        self.personTableView.beginUpdates()
        self.personTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.middle)
        self.personTableView.endUpdates()
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.persons.remove(at: indexPath.row)
            self.deletePersonFromTableView(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = self.persons[indexPath.row]
        return cell
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let alertName = UIAlertController(title: "Erreur", message:"Impossible d'ajouter. Renseignez le nom du voyage.", preferredStyle: .alert)
        alertName.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        
        if (identifier == "okNewTravelSegue") {
            guard self.travelNameLabel.hasText else {
                self.present(alertName, animated: true) {}
                return false
            }
        }
        return true
    }
    
    // MARK: segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okNewTravelSegue" {
            if travelNameLabel.text != "" {
                self.newTravel = Travel(name: travelNameLabel.text ?? " - ", pic: travelPic?.pngData() ?? Data())
        
                for pName in persons {
                    var newPerson: Person
                    if let person = PersonDAO.search(forName: pName) {
                        newPerson = person
                    }
                    else {
                        newPerson = Person(name: pName)
                    }
                    let participate: Participate = Participate(dateS: Date.init())
                    newPerson.addToPerson_participate(participate)
                    self.newTravel?.addToTravel_participate(participate)
                }
            }
            else {
                newTravel = nil
            }
        }
        else {
            newTravel = nil
        }
    }
    
    
}
