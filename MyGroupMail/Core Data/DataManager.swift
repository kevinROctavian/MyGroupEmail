//
//  DataManager.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation
import CoreData

public protocol DataManagerProtocol {
    func saveEmail(email: Email)
    func getEmail() throws -> [Email]
    func getEmailExcept(emails: [String]) throws -> [Email]
    
    func saveGroup(group: Group)
    func getGroup() throws -> [Group]
}

final class DataManager: DataManagerProtocol {
    
    
    private var managedObjectContext: NSManagedObjectContext! = nil
    private var emailEntity: NSEntityDescription! = nil
    private var groupEntity: NSEntityDescription! = nil
    
    required init() {
        debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        managedObjectContext = CoreDataStack.shared.mainContext
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        if let entityDescription = NSEntityDescription.entity(
            forEntityName: "Email",
            in: managedObjectContext) {
            emailEntity = entityDescription
        }
        
        if let entityDescription = NSEntityDescription.entity(
            forEntityName: "Group",
            in: managedObjectContext) {
            groupEntity = entityDescription
        }
    }
    
    // MARK: Email Operations
    
    func getEmail() throws -> [Email] {
        let fetchRequest = NSFetchRequest<DBEmail>(entityName: DBEmail.entityName)
        let email: [DBEmail]
        do {
            email = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            throw ErrorModel(errorDescription: "Core Data Error. Could not fetch. \(error), \(error.userInfo)")
        }
        if email.isEmpty {throw ErrorModel(errorDescription: "No Email Found")}
        return email.map {$0.toEmail()}
        
    }
    
    
    func getEmailExcept(emails: [String]) throws -> [Email] {
        let fetchRequest = NSFetchRequest<DBEmail>(entityName: DBEmail.entityName)
        fetchRequest.predicate = NSPredicate(format: "NOT (name IN %@)", emails)
        let email: [DBEmail]
        do {
            email = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            throw ErrorModel(errorDescription: "Core Data Error. Could not fetch. \(error), \(error.userInfo)")
        }
        if email.isEmpty {throw ErrorModel(errorDescription: "No Email Found")}
        return email.map {$0.toEmail()}
    }
    
    func saveEmail(email: Email) {
        managedObjectContext.perform {
            let object = DBEmail(entity: self.emailEntity, insertInto: self.managedObjectContext)
            object.update(from: email)
            self.saveContext(completion: {})
        }
    }
    
    // MARK: Group Operations
    
    
    func getGroup() throws -> [Group] {
        let fetchRequest = NSFetchRequest<DBGroup>(entityName: DBGroup.entityName)
        let email: [DBGroup]
        do {
            email = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            throw ErrorModel(errorDescription: "Core Data Error. Could not fetch. \(error), \(error.userInfo)")
        }
        if email.isEmpty {throw ErrorModel(errorDescription: "No Group Found")}
        return email.map {$0.toGroup()}
    }
    
    func saveGroup(group: Group) {
        if let object = isGroupExist(group: group){
            object.emails = group.emails.map{$0.toString()}
            object.name = group.name
            self.saveContext(completion: {})
            return
        }
        
        managedObjectContext.perform {
            let object = DBGroup(entity: self.groupEntity, insertInto: self.managedObjectContext)
            object.update(from: group)
            self.saveContext(completion: {})
        }
    }
    
    
    func isGroupExist(group: Group) -> DBGroup? {
        let fetchRequest = NSFetchRequest<DBGroup>(entityName: DBGroup.entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", group.groupId)
        do {
           let dbGroup = try managedObjectContext.fetch(fetchRequest)
            if (!dbGroup.isEmpty){
                return dbGroup[0]
            }
        } catch _ as NSError {
            
        }
        return nil
    }
    
    // MARK: Database Operation
    
    private func saveContext(completion: @escaping () -> Void) {
        managedObjectContext.perform {
            do {
                try self.managedObjectContext.save()
                completion()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
