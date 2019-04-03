//
//  PersonExpenseViewModel.swift
//  ProjetSwift
//
//  Created by user150862 on 4/2/19.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

class PersonExpenseSetViewModel {
    var dataset : [String: Float] = [:]
    
    init(person: Person) {
        if let personExpense = ExpenseDAO.search(forPerson: person) {
            self.dataset = personExpense
        }
    }
    
    public var count : Int{
        return self.dataset.count
    }
    
    public func get(expense_at index: Int) -> [String: Float]? {
        guard (index >= 0 ) && (index < self.count) else { return nil }
        var count : Int = 0
        for (name, amount) in dataset {
            if index == count {
                return [name:amount]
            }
            count += 1
        }
        return nil
    }
    
}
