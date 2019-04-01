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
    
    convenience init(pAmount: Float) {
        self.init(context: CoreDataManager.context)
        self.amount = pAmount
    }
    
}
