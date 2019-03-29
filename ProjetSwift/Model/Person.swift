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
}
