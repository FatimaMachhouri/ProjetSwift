//
//  TravelDetailsDAO.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import CoreData

class ExpenseDAO {
    static let request: NSFetchRequest<Expense> = Expense.fetchRequest()
    
    static func save() {
        _ = CoreDataManager.save()
    }
    
    static func fetchAll() -> [Expense]? {
        self.request.predicate = nil
        do {
            return try CoreDataManager.context.fetch(self.request)
        }
        catch {
            return nil
        }
    }
    
    static func search(forTravel travel: Travel) -> [Expense]? {        
        guard let expenses = travel.travel_expenses else {
            return nil
        }
        var result: [Expense]? = []
        for expense in expenses {
            let expense = (expense as! Expense)
            result?.append(expense)
        }
        return result
    }
    
    
    
    static func search(forPerson person: Person) -> [String:Float]? {
        guard let payments = person.person_pay else {
            return nil
        }
        var result: [String:Float]? = [:]
        for p in payments {
            let payement = p as? Pay
            if let expense = payement?.pay_expense {
                result?[expense.name] = payement?.amount
            }
        }
        return result
    }
    
    static func search(forExpense expense: Expense) -> [Person: Float]? {
        var result: [Person: Float] = [:]
        guard let pay = expense.expense_pay else {
            return nil
        }
        for payAmount in pay {
            let payAmount = (payAmount as! Pay)
            //in order to add, we do an assignation
            result[payAmount.pay_person!] = payAmount.amount
        }
        return result
    }
    
    static func searchConcern(forExpense expense: Expense) -> [Person: Float]? {
        var result: [Person: Float] = [:]
        guard let pay = expense.expense_pay else {
            return nil
        }
        for payConcern in pay {
            let payConcern = (payConcern as! Pay)
            //in order to add, we do an assignation
            result[payConcern.pay_person!] = payConcern.amountConcerned
        }
        return result
    }

    
}
