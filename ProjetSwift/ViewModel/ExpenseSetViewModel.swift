//
//  ExpenseSetViewModel.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ExpenseSetViewModelDelegate {
    func dataSetChanged()
    func expenseAdded(at indexPath: IndexPath)
    func expenseDeleted(at indexPath: IndexPath)
}

class ExpenseSetViewModel {
    var dataset : [Expense] = []
    var delegate : ExpenseSetViewModelDelegate? = nil
    
    init() {
        if let expenses = ExpenseDAO.fetchAll() {
            self.dataset = expenses
        }
    }
    
    init(travel: Travel) {
        if let expenses = ExpenseDAO.search(forTravel: travel) {
            self.dataset = expenses
        }
    }
    
    public func add(expense: Expense){
        self.dataset.append(expense)
        self.delegate?.expenseAdded(at: IndexPath(row: self.dataset.count-1, section: 0))
    }
    
    public var count : Int{
        return self.dataset.count
    }
    
    public func get(expenseAt index: Int) -> Expense? {
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.dataset[index]
    }
    
    public func delete(expenseAt index: Int) {
        let expense = self.dataset[index]
        delegate?.expenseDeleted(at: IndexPath(row: self.dataset.count, section: 0))
        CoreDataManager.context.delete(expense)
        CoreDataManager.save()
    }
    
}
