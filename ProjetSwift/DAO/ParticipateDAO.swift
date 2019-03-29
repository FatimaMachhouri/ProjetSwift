//
//  ParticipateDAO.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import CoreData

class ParticipateDAO {
    static let request: NSFetchRequest<Person> = Person.fetchRequest()
    
    static func save() {
        _ = CoreDataManager.save()
    }
    
}
