//
//  GroupViewModel.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation

protocol GroupViewModelProtocol{
    func save(id: String, name: String, emailsInGroup: [Email])
    func getAllEmailListExclude(email: [Email])
}

class GroupViewModel: ObservableObject{
    private let groupRepository: GroupRepositoryProtocol
    private let emailRepository: EmailRepositoryProtocol
    
    @Published var emails: [Email] = []
    
    var group = Group()
    
    init(
        groupRepository: GroupRepositoryProtocol = GroupRepository(),
        emailRepository: EmailRepositoryProtocol = EmailRepository()
    ) {
        self.groupRepository = groupRepository
        self.emailRepository = emailRepository
    }
}

extension GroupViewModel: GroupViewModelProtocol{
    func save(id: String, name: String, emailsInGroup: [Email]){
        var emailWillBeSaved: [Email] = []
        emailWillBeSaved.append(contentsOf: emailsInGroup.filter({ email in
            email.isChecked == true
        }))
        emailWillBeSaved.append(contentsOf: self.emails.filter({ email in
            email.isChecked == true
        }))
        
        let group = Group(name: name, emails: emailWillBeSaved, groupId: id)
        groupRepository.saveGroup(group: group)
    }
    
    func getAllEmailListExclude(email: [Email]){
        emails = emailRepository.getAllEmailListExclude(email: email)
    }
}

