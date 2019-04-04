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
            if let expense = expense as? Expense {
                result?.append(expense)
            }
        }
        return result
    }
    
    /// Returns a map with as key, the name of the expense and as value the amount payed by the person for the expense
    static func search(forPerson person: Person) -> [String: Float]? {
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
    
    static func search(forPerson person: Person, forTravel travel: Travel) -> [String: Float]? {
        guard let payments = person.person_pay else {
            return nil
        }
        var result: [String:Float]? = [:]
        for p in payments {
            let payement = p as? Pay
            if let expense = payement?.pay_expense {
                if expense.expense_travel == travel {
                    result?[expense.name] = payement?.amount
                }
            }
        }
        return result
    }
    
    /// Returns a map with as key the Person concerned by the expense and as value the amount payed by the person
    static func search(forExpense expense: Expense) -> [Person: Float]? {
        var result: [Person: Float] = [:]
        guard let pay = expense.expense_pay else {
            return nil
        }
        for payAmount in pay {
            guard let payAmount = payAmount as? Pay else {
                continue
            }
            if let person = payAmount.pay_person {
                result[person] = payAmount.amount
            }
        }
        return result
    }
    
    static func search(forTravel travel: Travel, forPerson person: Person) -> [(Float, Float)]? {
        guard let personPay = person.person_pay else {
            return nil
        }
        var result: [(Float, Float)]? = []
        for p in personPay {
            guard let pay = p as? Pay else {
                continue
            }
            if let expense = pay.pay_expense {
                if expense.expense_travel == travel {
                    result?.append((pay.amount, pay.amountConcerned))
                }
            }
        }
        return result
    }
    
    /// Returns a map with as key the Person concerned by the expense and as value the amount of the expense that concerns the person
    static func searchConcern(forExpense expense: Expense) -> [Person: Float]? {
        var result: [Person: Float] = [:]
        guard let pay = expense.expense_pay else {
            return nil
        }
        for payConcern in pay {
            guard let payConcern = payConcern as? Pay else {
                continue
            }
            if let person = payConcern.pay_person {
                result[person] = payConcern.amountConcerned
            }
        }
        return result
    }

    
}
