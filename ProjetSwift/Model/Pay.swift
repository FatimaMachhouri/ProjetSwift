//
//  Pay.swift
//  ProjetSwift
//
//  Created by user150862 on 4/1/19.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

extension Pay {
    public var pAmount: Float {
        return self.amount
    }
    
    public var cAmount: Float {
        return self.amountConcerned
    }
    
    convenience init(pAmount: Float) {
        self.init(context: CoreDataManager.context)
        self.amount = pAmount
    }
    
    convenience init(pAmount: Float, cAmount: Float) {
        self.init(context: CoreDataManager.context)
        self.amount = pAmount
        self.amountConcerned = cAmount
    }
    
}
