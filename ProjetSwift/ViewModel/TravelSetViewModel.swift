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

protocol TravelSetViewModelDelegate {
    func dataSetChanged()
    func travelAdded(at indexPath: IndexPath)
}

class TravelSetViewModel {
    var delegate: TravelSetViewModelDelegate? = nil
    var travelFetched: NSFetchedResultsController<Travel>
    
    init(data: NSFetchedResultsController<Travel>) {
        self.travelFetched = data
    }
    
    public func add(travel: Travel) {
        if let indexPath = self.travelFetched.indexPath(forObject: travel) {
            self.delegate?.travelAdded(at: indexPath)
        }
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
