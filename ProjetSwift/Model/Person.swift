//
//  Person.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

extension Person {
    public var name: String {
        return self.personName ?? ""
    }
    
    convenience init(name: String) {
        self.init(context: CoreDataManager.context)
        self.personName = name
    }
    
    var balancedExpenses: Float {
        var result: Float = 0.0
        guard let concern = self.person_pay else {
            return 0
        }
        for concernAmount in concern {
            let concernAmount = (concernAmount as! Pay)
            result = result + concernAmount.amountConcerned
        }
        return self.totalExpenses - result
    }
    
    var totalExpenses: Float {
        var result: Float = 0.0
        guard let pay = self.person_pay else {
            return 0
        }
        for payAmount in pay {
            let payAmount = (payAmount as! Pay)
            result = result + payAmount.amount
        }
        return result
    }
    
}
