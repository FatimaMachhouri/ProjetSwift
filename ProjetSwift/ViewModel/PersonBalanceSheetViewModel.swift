//
//  PersonBalanceSheetViewModel.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 03/04/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

class PersonBalanceSheetViewModel {
    var exchange: [(String, Float)] = []
    
    init(person: Person, travel: Travel) {
        guard let balances = PersonDAO.getBalanceSheets(forTravel: travel) else {
            return
        }
        var persons: [String] = []
        var amounts: [Float] = []
        for (person, amount) in balances {
            persons.append(person.name)
            amounts.append(amount)
        }
        
        var exchanges: [String:[(String, Float)]] = [:]
        for personName in persons {
            exchanges[personName] = []
        }
        while !isBalanced(amounts: amounts) {
            print("haha")
            guard balances.values.count > 0 else {
                return
            }
            // force unwrap because count is tested in guard
            let min: Float = amounts.min()!
            let max: Float = amounts.max()!
            let indexMin: Int = amounts.firstIndex(of: min)!
            let indexMax: Int = amounts.firstIndex(of: max)!
            
            if max >= -min {
                amounts[indexMax] = max + min
                amounts[indexMin] = 0
                exchanges[persons[indexMax]]?.append((persons[indexMin], -min))
                exchanges[persons[indexMin]]?.append((persons[indexMax], min))
            }
            else if max < -min {
                amounts[indexMax] = 0
                amounts[indexMin] = min + max
                exchanges[persons[indexMax]]?.append((persons[indexMin], max))
                exchanges[persons[indexMin]]?.append((persons[indexMax], -max))
            }
        }
        self.exchange = exchanges[person.name] ?? []
    }
    
    func isBalanced(amounts: [Float]) -> Bool {
        for amount in amounts {
            guard amount == 0 else {
                return false
            }
        }
        return true
    }
    
    public var count : Int{
        return self.exchange.count
    }
    
    public func get(exchange_at index: Int) -> (String, Float)? {
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.exchange[index]
    }
}
