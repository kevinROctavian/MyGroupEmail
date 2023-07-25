//
//  EmailViewModel.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation

protocol EmailViewModelProtocol{
    func saveEmail(email: Email)
}


class EmailViewModel: ObservableObject{
    private let emailRepository: EmailRepositoryProtocol
    
    
    init(emailRepository: EmailRepositoryProtocol = EmailRepository()) {
        self.emailRepository = emailRepository
    }
}

extension EmailViewModel: EmailViewModelProtocol{
    func saveEmail(email: Email){
        self.emailRepository.saveEmail(email: email)
    }
}
