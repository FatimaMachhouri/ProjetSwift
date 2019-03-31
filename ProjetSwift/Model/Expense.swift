//
//  Expense.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 30/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

extension Expense {
    public var name: String {
        return self.expenseName ?? ""
    }
    
    public var date: Date? {
        return self.expenseDate ?? nil
    }
    
    public var pic: Data {
        return self.expensePicture ?? Data()
    }
    
    convenience init(name: String, date: Date, pic: Data) {
        self.init(context: CoreDataManager.context)
        self.expenseName = name
        self.expenseDate = date
        self.expensePicture = pic
    }
    
    convenience init(name: String) {
        self.init(context: CoreDataManager.context)
        self.expenseName = name
    }
    
    var amount: Float {
        get {
            guard let expense_p = self.expense_pay else {
                return 0
            }
            var amountExpense: Float = 0
            for pay in expense_p {
                let amount = (pay as! Pay).amount
                amountExpense += amount
            }
            return amountExpense

        }
    }
    
}
