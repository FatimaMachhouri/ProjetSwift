//
//  PersonsExpenseViewModel.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol PersonsExpenseSetViewModelDelegate {
    func dataSetChanged()
}

class PersonsExpenseSetViewModel {
    
    var dataset : [Person: Float] = [:]
    var datasetConcern : [Person: Float] = [:]
    var delegate : PersonsExpenseSetViewModelDelegate? = nil
    
    init(expense: Expense) {
        if let personsExpense = ExpenseDAO.search(forExpense: expense) {
            self.dataset = personsExpense
        }
        if let personsExpenseConcern = ExpenseDAO.searchConcern(forExpense: expense) {
            self.datasetConcern = personsExpenseConcern
        }
    }
    
    public var count : Int{
        return self.dataset.count
    }
    
    public func get(person_amount_at index: Int) -> [Person: Float]? {
        guard (index >= 0 ) && (index < self.count) else { return nil }
        
        var count : Int = 0
        for (person, amount) in dataset {
            if index == count {
                return [person: amount]
            }
            count += 1
        }
        return nil
    }
    
    public func get(person_amountConcern_at index: Int) -> [Person: Float]? {
        guard (index >= 0 ) && (index < self.count) else { return nil }
        
        var count : Int = 0
        for (person, amount) in datasetConcern {
            if index == count {
                return [person: amount]
            }
            count += 1
        }
        return nil
    }
    

}
