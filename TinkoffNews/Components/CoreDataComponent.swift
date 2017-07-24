//
//  CoreDataComponent.swift
//  TinkoffNews
//
//  Created by jufina on 21.07.17.
//  Copyright © 2017 jufina. All rights reserved.
//

import Foundation
import CoreData

protocol DataBaseInterface: class {
    func save()
    func create<T: NSManagedObject>(type: T.Type) -> T where T:Managed
    func find<T: NSManagedObject>(by id: String, type: T.Type) -> T? where T:Managed
    func getAllObjects<T: NSManagedObject>(type: T.Type, sortedBy key: String, ascending: Bool) -> [T] where T:Managed
}

class CoreDataComponent {
    let mainContext = CoreDataStack.mainContext
    let backgroundContext = CoreDataStack.backgroundContext
    
    
    //MARK: - Private
    
    fileprivate func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            }
            catch {
                context.rollback()
            }
            if let parentContext = context.parent {
                save(context: parentContext)
            }
        }
    }
}


//MARK: - DataBaseInterface

extension CoreDataComponent: DataBaseInterface {
    func save() {
        save(context: backgroundContext)
    }
    
    func create<T: NSManagedObject>(type: T.Type) -> T where T:Managed {
        return NSEntityDescription.insertNewObject(forEntityName: T.entityName(), into: self.backgroundContext) as! T
    }
    
    func find<T: NSManagedObject>(by id: String, type: T.Type) -> T? where T:Managed {
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.entityName())
        request.predicate = NSPredicate(format: "%K == %@", "id", id)
        let results = try? backgroundContext.fetch(request)
        return results?.first
    }
    
    func getAllObjects<T: NSManagedObject>(type: T.Type, sortedBy key: String, ascending: Bool) -> [T] where T:Managed {
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: T.entityName())
        request.sortDescriptors = [ NSSortDescriptor(key: key, ascending: ascending) ]
        
        return try! mainContext.fetch(request)
    }
}
