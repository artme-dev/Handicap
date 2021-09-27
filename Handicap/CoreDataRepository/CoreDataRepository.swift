//
//  CoreDataRepository.swift
//  HandicapCalculator
//
//  Created by Артём on 19.09.2021.
//

import CoreData

enum CoreDataError: Error {
    case invalidManagedObjectType
}

class CoreDataRepository<Entity: NSManagedObject>: DataRepository {
    
    private let managedContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedContext = managedObjectContext
    }
    
    func get(using predicate: NSPredicate?,
             sortDescriptors: [NSSortDescriptor]? = nil,
             fetchLimit: Int? = nil) throws -> [Entity] {
        
        let fetchRequest = Entity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        if let fetchLimit = fetchLimit {
            fetchRequest.fetchLimit = fetchLimit
        }
        
        guard let fetchResults = try managedContext.fetch(fetchRequest) as? [Entity] else {
            throw CoreDataError.invalidManagedObjectType
        }
        
        return fetchResults
    }

    func create() throws -> Entity {
        let className = String(describing: Entity.self)
        let managedObject = NSEntityDescription.insertNewObject(forEntityName: className,
                                                                into: managedContext)
        guard let managedObject = managedObject as? Entity else {
            throw CoreDataError.invalidManagedObjectType
        }
        return managedObject
    }

    func delete(entity: Entity) throws {
        managedContext.delete(entity)
    }
    
    func deleteAll(using predicate: NSPredicate?) throws {
        let deletingFetchRequest = Entity.fetchRequest()
        deletingFetchRequest.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deletingFetchRequest)
        
        try managedContext.execute(deleteRequest)
    }
    
    @discardableResult func applyChanges() throws -> Bool {
        guard managedContext.hasChanges else {
            return false
        }
        try managedContext.save()
        return true
    }
}
