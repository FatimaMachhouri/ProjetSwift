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
    var dataset : [(String, Float)] = []
    var delegate: PersonExpenseDelegate? = nil
    
    init(person: Person) {
        if let personExpense = ExpenseDAO.search(forPerson: person) {
            for (name, amount) in personExpense {
                dataset.append((name, amount))
            }
        }
    }
    
    public var count : Int{
        return self.dataset.count
    }
    
    public func add(expense: Expense) {
        dataset.append((expense.name, expense.amount))
        self.delegate?.personExpenseAdded(at: IndexPath(row: self.dataset.count-1, section: 0))
    }
    
    public func get(expense_at index: Int) -> (String, Float)? {
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.dataset[index]
    }
    
}
