//
//  DBEmail.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation
import CoreData

@objcMembers
final class DBEmail: NSManagedObject {
    static var entityName: String {
        return "Email"
    }
    @NSManaged var name: String
}

extension DBEmail {
    func toEmail() -> Email {
        Email(name: name, isChecked: false)
    }
    
    func update(from email: Email) {
        name = email.name
    }
}
