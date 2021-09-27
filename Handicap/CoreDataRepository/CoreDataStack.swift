//
//  CoreDataStack.swift
//  HandicapCalculator
//
//  Created by Артём on 19.09.2021.
//

import CoreData

protocol CoreDataContextProvider {
    func getViewContext() -> NSManagedObjectContext
    func performBackgroundTask(_: @escaping (NSManagedObjectContext) -> Void)
}

class CoreDataStack {
    private let objectModelName = "HandicapCalculator"
    
    static let shared: CoreDataStack = CoreDataStack()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: objectModelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var viewContext = persistentContainer.viewContext
    
    func getViewContext() -> NSManagedObjectContext {
        return viewContext
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }
}
