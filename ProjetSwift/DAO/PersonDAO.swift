//
//  PersonDAO.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import CoreData

class PersonDAO {
    static let request: NSFetchRequest<Person> = Person.fetchRequest()
    
    static func save() {
        _ = CoreDataManager.save()
    }
    
    static func fetchAll() -> [Person]?{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.fetch(self.request)
        }
        catch{
            return nil
        }
    }
    
    static func search(forTravel travel: Travel) -> [Person]? {
        guard let participates = travel.travel_participate else {
            return nil
        }
        var result: [Person]? = []
        for p in participates {
            guard let participate = p as? Participate else {
                continue
            }
            if let person = participate.participate_person {
                result?.append(person)
            }
        }
        return result
    }
    
    static func search(forName name: String) -> Person? {
        self.request.predicate = NSPredicate(format: "personName == %@", name)
        do {
            let persons = try CoreDataManager.context.fetch(request) as [Person]?
            if persons?.count == 0 {
                return nil
            }
            else if persons?.count == 1{
                return persons?[0]
            }
            else { return nil }
        }
        catch {
            return nil
        }
    }

    static func getBalanceSheet(forTravel travel: Travel, forPerson person: Person) -> Float? {
        var sommeExpense: Float = 0
        guard let allPayments = person.person_pay else {
            return nil
        }
        for p in allPayments {
            let pay = p as? Pay
            if pay?.pay_expense?.expense_travel == travel {
                if let amount = pay?.amount {
                    if let amountConcerned = pay?.amountConcerned {
                        sommeExpense = sommeExpense + (amount - amountConcerned)
                    }
                }
            }
        }
        return sommeExpense
    }
    
    static func getBalanceSheets(forTravel travel: Travel) -> [Person: Float]? {
        var result: [Person: Float]? = [:]
        guard let participates = travel.travel_participate else {
            return nil
        }
        for p in participates {
            let participate = p as? Participate
            if let person = participate?.participate_person {
                if let balance = self.getBalanceSheet(forTravel: travel, forPerson: person) {
                    result?[person] = balance
                }
            }
        }
        return result
    }
    
}
