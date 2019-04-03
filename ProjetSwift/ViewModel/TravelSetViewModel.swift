//
//  TravelSetViewModel.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 26/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TravelSetViewModel {
    var travelFetched: NSFetchedResultsController<Travel>
    
    init(data: NSFetchedResultsController<Travel>) {
        self.travelFetched = data
    }
    
    public var count : Int {
        return self.travelFetched.fetchedObjects?.count ?? 0
    }
    
    public func get(travelAt index: Int) -> Travel {
        return self.travelFetched.object(at: IndexPath(row: index, section: 0))
    }
    
    public func delete(travelAt index: Int) {
        let travel = self.travelFetched.object(at: IndexPath(row: index, section: 0))
        CoreDataManager.context.delete(travel)
    }
}
