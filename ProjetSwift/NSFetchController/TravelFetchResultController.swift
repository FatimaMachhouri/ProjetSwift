//
//  TravelFaetchRe.swift
//  ProjetSwift
//
//  Created by Fatima Machhouri on 26/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class TravelFetchResultController: NSObject, NSFetchedResultsControllerDelegate {
    let tableView: UITableView

    init(view: UITableView) {
        self.tableView = view
        super.init()
        do{
            try self.travelsFetched.performFetch()
        }
        catch let error as NSError { fatalError(error.description) }
    }
    
    lazy var travelsFetched : NSFetchedResultsController<Travel> = {
        // prepare a request
        let request: NSFetchRequest<Travel> = Travel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Travel.travelName), ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    private func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
        _ = CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        default: break
        }
    }
    
}

