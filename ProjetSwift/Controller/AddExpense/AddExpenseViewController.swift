//
//  AddExpenseViewController.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 31/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit

class AddExpenseViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var expenseName: UITextField!
    @IBOutlet weak var expenseTotal: UILabel!
    @IBOutlet weak var expenseDate: UITextField!
    @IBOutlet weak var tableViewConcern: UITableView!
    
    var tableViewController: AddExpenseTableViewController!
    var tableViewControllerConcern: AddExpenseTableViewController!
    
    var newExpense: Expense? = nil
    var travel: Travel? = nil
    var expensePic: UIImage? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let t = travel else {
            fatalError("Unusal error")
        }
        self.tableViewController = AddExpenseTableViewController(tableView: self.tableView, travel: t)
        self.tableViewControllerConcern = AddExpenseTableViewController(tableView: self.tableViewConcern, travel: t)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func precedentAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (success) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                sender.isSelected = !sender.isSelected
                sender.transform = .identity
            }, completion: nil)
        }
    }
    
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
            expensePic = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func isCellConcerned(cell: AddExpenseTableViewCell?) -> Bool {
        return cell?.buttonCheckBox.state == .normal
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        var total: Float = 0
        for c in self.tableView.visibleCells {
            let cell = c as? AddExpenseTableViewCell
            if !self.isCellConcerned(cell: cell) {
                continue
            }
            let amount = cell?.amountTextField.text ?? "0"
            total += Float(amount) ?? 0
        }
        self.expenseTotal.text = String(total)
    }
    
    func textFieldContent(tableView: UITableView) -> [Person: Float?] {
        var result: [Person: Float?] = [:]
        for c in tableView.visibleCells {
            let cell = c as? AddExpenseTableViewCell
            if !self.isCellConcerned(cell: cell) { continue }
            let amount = cell?.amountTextField.text ?? "0"
            if let name = cell?.personNameLabel.text {
                if let person = PersonDAO.search(forName: name) {
                    result[person] = Float(amount) ?? 0
                }
            }
        }
        return result
    }
    
    func merge(map1: [Person: Float?], map2: [Person: Float?]) -> [Person: [Float?]] {
        var result: [Person: [Float?]] = [:]
        var map: [Person: Float?] = [:]
        
        //get the longest map to iterate on
        if map1.count > map2.count {
            map = map1
        }
        else {
            map = map2
        }
        
        for person in map {
            var amounts: [Float?] = [0,0]
            amounts[0] = map1[person.key] ?? 0
            amounts[1] = map2[person.key] ?? 0
            result[person.key] = amounts
        }
        return result
    }
    
    //return the sum of the TextFields of an UITableView
    private func totalTableView(tableView: UITableView) -> Float {
        let countTableView = tableView.numberOfSections
        var somme: Float = 0
        
        for section in 0 ..< countTableView {
            let rowCount = tableView.numberOfRows(inSection: section)
            for row in 0 ..< rowCount {
                let cell = tableView.cellForRow(at: NSIndexPath(row: row, section: section) as IndexPath) as? AddExpenseTableViewCell
                let amount = Float(cell?.amountTextField.text ?? "0") ?? 0
                somme = somme + amount
            }
        }
        return somme
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let alertName = UIAlertController(title: "Erreur", message:"Impossible d'ajouter. Renseignez le nom de la dépense.", preferredStyle: .alert)
        alertName.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
        
        let alertAmounts = UIAlertController(title: "Erreur", message:"Impossible d'ajouter. Les montants payés et concernés ne sont pas égaux.", preferredStyle: .alert)
        alertAmounts.addAction(UIAlertAction(title: "OK", style: .default) { _ in })
       
        if (identifier == "okNewExpenseSegue") {
            guard self.expenseName.hasText else {
                self.present(alertName, animated: true) {}
                return false
            }
            
            guard self.totalTableView(tableView: tableView) == self.totalTableView(tableView: tableViewConcern) else {
                self.present(alertAmounts, animated: true) {}
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "okNewExpenseSegue" {
            if let name = self.expenseName.text {
                let format = DateFormatter()
                format.dateFormat = "dd/MM/yyyy"
                var date: Date = Date.init()
                if let textDate = self.expenseDate.text {
                    date = format.date(from: textDate) ?? date
                }
                self.newExpense = Expense(name: name, date: date, pic: expensePic?.pngData() ?? Data())
                // force unwrap newExpense just created
                self.travel?.addToTravel_expenses(self.newExpense!)
                let amountPaid: [Person: Float?] = self.textFieldContent(tableView: tableView)
                let amountConcerned: [Person: Float?] = self.textFieldContent(tableView: tableViewConcern)
                let resultToInsert: [Person: [Float?]] = merge(map1: amountPaid, map2: amountConcerned)
                
                for person in resultToInsert {
                    let pay = Pay(pAmount: person.value[0] ?? 0, cAmount: person.value[1] ?? 0)
                    person.key.addToPerson_pay(pay)
                    pay.pay_expense = newExpense
                }
            }
        }
    }
     
}
