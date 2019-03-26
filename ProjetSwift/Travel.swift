//
//  Travel.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 26/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

extension Travel {
    public var name: String {
        return self.travelName ?? ""
    }
    
    convenience init(name: String) {
        self.init(context: CoreDataManager.context)
        self.travelName = name
    }
}
