//
//  EmailRepository.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation

protocol EmailRepositoryProtocol{
    func saveEmail(email: Email)
    func getEmailList() -> [Email]
    func getAllEmailListExclude(email: [Email]) -> [Email]
}

final class  EmailRepository {
    private let storageService: StorageServiceProtocol
    
    init(storageService: StorageServiceProtocol = StorageService()) {
        self.storageService = storageService
    }
}

extension EmailRepository: EmailRepositoryProtocol{
    func getAllEmailListExclude(email: [Email]) -> [Email] {
        self.storageService.getEmailExcept(email: email)
    }
    
    func saveEmail(email: Email) {
        self.storageService.persistEmail(email: email)
    }
    
    func getEmailList() -> [Email] {
        self.storageService.getEmail()
    }
}


