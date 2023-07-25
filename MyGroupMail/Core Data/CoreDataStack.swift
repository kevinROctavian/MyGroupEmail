//
//  CoreDataStack.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation
import CoreData

class CoreDataStack {

       static let shared = CoreDataStack()

       lazy var container: NSPersistentContainer = {

           let container = NSPersistentContainer(name: "MyGroupMail")
           
           container.loadPersistentStores { (_, error) in
               if let error = error {
                   fatalError("Failed to load persistent stores: \(error)")
               }
           }
           return container
       }()


       var mainContext: NSManagedObjectContext {
           return container.viewContext
       }
}
