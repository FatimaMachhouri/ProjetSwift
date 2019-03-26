//
//  CoreDataManager.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 26/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{
    /// context manager
    static let context : NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
            else {
                print("no context")
                exit(EXIT_FAILURE)
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    class func entity(forName name: String) -> NSEntityDescription {
        guard let entity = NSEntityDescription.entity(forEntityName: name, in: self.context)
            else{ fatalError("get entity \(name) description failed") }
        return entity
    }
    
    class func save() -> NSError? {
        // try to save it
        do {
            try CoreDataManager.context.save()
            return nil
            
        } catch let error as NSError{ return error }
    }
}
