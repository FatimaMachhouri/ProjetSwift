//
//  PersonSetViewModel.swift
//  ProjetSwift
//
//  Created by etud ig on 29/03/2019.
//  Copyright © 2019 F&Y. All rights reserved.
//

import Foundation
import UIKit
import CoreData


protocol PersonSetViewModelDelegate {
    func dataSetChanged()
    func personAdded(at indexPath: IndexPath)
}

class PersonSetViewModel {
    var dataset : [Person] = []
    var delegate : PersonSetViewModelDelegate? = nil
    
    init() {
        if let persons = PersonDAO.fetchAll() {
            self.dataset = persons
        }
    }
    
    init(travel: Travel) {
        if let persons = PersonDAO.search(forTravel: travel) {
            self.dataset = persons
        }
    }
    
    public func add(person: Person){
        self.dataset.append(person)
        self.delegate?.personAdded(at: IndexPath(row: self.dataset.count-1, section: 0))
    }
    
    public var count : Int{
        return self.dataset.count
    }

    public func get(personAt index: Int) -> Person?{
        guard (index >= 0 ) && (index < self.count) else { return nil }
        return self.dataset[index]
    }
    
}
