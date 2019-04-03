//
//  PersonExpenseViewModel.swift
//  ProjetSwift
//
//  Created by user150862 on 4/2/19.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

protocol PersonExpenseDelegate {
    func personExpenseAdded(at indexPath: IndexPath)
}

class PersonExpenseSetViewModel {
    var dataset : [String: Float] = [:]
    var delegate: PersonExpenseDelegate? = nil
    
    init(person: Person) {
        if let personExpense = ExpenseDAO.search(forPerson: person) {
            self.dataset = personExpense
        }
    }
    
    public var count : Int{
        return self.dataset.count
    }
    
    public func add(expense: Expense) {
        dataset[expense.name] = expense.amount
        self.delegate?.personExpenseAdded(at: IndexPath(row: self.dataset.count-1, section: 0))
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
