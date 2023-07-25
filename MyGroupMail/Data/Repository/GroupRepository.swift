//
//  GroupRepository.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation

protocol GroupRepositoryProtocol{
    func saveGroup(group: Group)
    func getGroupList() -> [Group]
}

final class GroupRepository {
    private let storageService: StorageServiceProtocol
    
    init(storageService: StorageServiceProtocol = StorageService()) {
        self.storageService = storageService
    }
}

extension GroupRepository: GroupRepositoryProtocol{
    func saveGroup(group: Group) {
        self.storageService.persistGroup(group: group)
    }
    
    func getGroupList() -> [Group] {
        self.storageService.getGroup()
    }
}
