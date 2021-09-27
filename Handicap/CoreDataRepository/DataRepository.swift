//
//  s.swift
//  HandicapCalculator
//
//  Created by Артём on 20.09.2021.
//

import CoreData

protocol DataRepository {
    associatedtype Entity: NSManagedObject

    func get(using predicate: NSPredicate?,
             sortDescriptors: [NSSortDescriptor]? ,
             fetchLimit: Int?) throws -> [Entity]

    func create() throws -> Entity

    func delete(entity: Entity) throws

    func deleteAll(using predicate: NSPredicate?) throws

    @discardableResult func applyChanges() throws -> Bool
}
