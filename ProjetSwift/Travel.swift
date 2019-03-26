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
    
    public var pic: Data {
        return self.picture ?? Data()
    }
    
    convenience init(name: String, pic: Data) {
        self.init(context: CoreDataManager.context)
        self.travelName = name
        self.picture = pic
    }
}
