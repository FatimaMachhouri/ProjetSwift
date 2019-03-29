//
//  Participate.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation

extension Participate {
    public var dateS: Date? {
        return self.startDate ?? nil
    }
    
    public var dateE: Date? {
        return self.endDate ?? nil
    }
    
    convenience init(dateS: Date) {
        self.init(context: CoreDataManager.context)
        self.startDate = dateS
    }
}
