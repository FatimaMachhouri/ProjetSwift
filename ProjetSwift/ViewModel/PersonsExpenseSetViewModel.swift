//
//  PersonsExpenseViewModel.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

class PersonsExpenseSetViewModel {
    var datasetPay : [Person: Float] = [:]
    var datasetConcern : [Person: Float] = [:]
    
    init(expense: Expense) {
        if let personsExpense = ExpenseDAO.search(forExpense: expense) {
            self.datasetPay = personsExpense
        }
        if let personsExpenseConcern = ExpenseDAO.searchConcern(forExpense: expense) {
            self.datasetConcern = personsExpenseConcern
        }
    }
    
    public var count: Int{
        return self.datasetPay.count
    }
    
    public func get(person_amount_at index: Int) -> [Person: Float]? {
        guard (index >= 0 ) && (index < self.count) else { return nil }
        
        var count : Int = 0
        for (person, amount) in datasetPay {
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
