//
//  MyGroupMailStorageService.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation

protocol StorageServiceProtocol {
    func persistEmail(email: Email)
    func getEmail() -> [Email]
    func getEmailExcept(email: [Email]) -> [Email]
    func persistGroup(group: Group)
    func getGroup() -> [Group]
}

final class StorageService {
    private let dataManager: DataManager

    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
    }
}

extension StorageService: StorageServiceProtocol {
    func getEmailExcept(email: [Email]) -> [Email] {
        let email = try? dataManager.getEmailExcept(emails: email.map{$0.toString()})
        return email ?? []
    }
    
    
    // MARK: Email Operations
    
    func persistEmail(email: Email) {
        dataManager.saveEmail(email: email)
    }
    
    func getEmail() -> [Email] {
        let email = try? dataManager.getEmail()
        return email ?? []
    }
    
    // MARK: Group Operations
    
    func persistGroup(group: Group) {
        dataManager.saveGroup(group: group)
    }
    
    func getGroup() -> [Group] {
        let groups = try? dataManager.getGroup()
        return groups ?? []
    }
}
