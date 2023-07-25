//
//  HomeViewModel.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import UIKit

protocol HomeViewModelProtocol{
    func getGroupList()
    func composeMessage(group: Group)
}

class HomeViewModel: ObservableObject{
    private let groupRepository: GroupRepositoryProtocol
    
    @Published var group: [Group] = []
    
    init(groupRepository: GroupRepositoryProtocol = GroupRepository()) {
        self.groupRepository = groupRepository
    }
}

extension HomeViewModel: HomeViewModelProtocol{
    func composeMessage(group: Group) {
        print("Compose message")
        let recipients = group.emails.map{$0.toString()}
        if let url = URL(string: "mailto:\(recipients.joined(separator: "%2C"))"){
            UIApplication.shared.open(url)
        }
    }
    
    
    func getGroupList() {
        group = self.groupRepository.getGroupList()
    }
    
}
