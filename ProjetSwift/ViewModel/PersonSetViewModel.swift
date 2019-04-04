//
//  PersonSetViewModel.swift
//  ProjetSwift
//
//  Created by etud ig on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

protocol PersonSetViewModelDelegate {
    func dataSetChanged()
    func personAdded(at indexPath: IndexPath)
}

class PersonSetViewModel {
    var dataset : [Person] = []
    var delegate : PersonSetViewModelDelegate? = nil
    var travel: Travel
    
    init(travel: Travel) {
        if let persons = PersonDAO.search(forTravel: travel) {
            self.dataset = persons
        }
        self.travel = travel
    }
    
    public func add(person: Person){
        self.dataset.append(person)
        self.delegate?.personAdded(at: IndexPath(row: self.dataset.count-1, section: 0))
    }
    
    public var count: Int{
        return self.dataset.count
    }

    public func get(personAt index: Int) -> Person?{
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.dataset[index]
    }
    
    public func totalExpenses(forPerson person: Person) -> Float? {
        guard let expenses = ExpenseDAO.search(forTravel: self.travel, forPerson: person) else {
            return nil
        }
        var somme: Float = 0
        for expense in expenses {
            somme = somme + expense.0
        }
        return somme
    }
    
    public func balancedExpenses(forPerson person: Person) -> Float? {
        guard let expenses = ExpenseDAO.search(forTravel: self.travel, forPerson: person) else {
            return nil
        }
        var somme: Float = 0
        for expense in expenses {
            somme = somme + expense.1
        }
        guard let totalExpenses = self.totalExpenses(forPerson: person) else {
            return nil
        }
        return totalExpenses - somme
    }
    
}
