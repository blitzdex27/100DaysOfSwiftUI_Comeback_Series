//
//  Persistence.swift
//  FlashZilla2
//
//  Created by Dexter Ramos on 2/12/25.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Card")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(filePath: "/dev/null")
            container.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        }
        
        container.loadPersistentStores { storeDesc, error in
            if let error {
                fatalError("Failed to load Persistent Stores: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        let context = controller.container.viewContext
        
        let sample1 = Card(context: context)
        sample1.prompt = "What is 2 + 2?"
        sample1.answer = "4"
        
        let sample2 = Card(context: context)
        sample2.prompt = "What is the capital of France?"
        sample2.answer = "Paris"
        
//        context.performAndWait {
//            context.setValue(Date(), forKey: "creationDate")
//            context.setValue(Date(), forKey: "modificationDate")
//            context.setValue(1, forKey: "version")
//        }
        
        try! context.save()
        
        return controller
    }()
}
