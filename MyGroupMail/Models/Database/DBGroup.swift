//
//  DBGroup.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation
import CoreData

@objcMembers
final class DBGroup: NSManagedObject {
    static var entityName: String {
        return "Group"
    }
    @NSManaged var name: String
    @NSManaged var id: String
    @NSManaged var emails: [String]
    
}

extension DBGroup {
    func toGroup() -> Group {
        Group(name: name, emails: emails.map{ Email(name: $0, isChecked: true) }, groupId: id)
    }
    
    func update(from group: Group) {
        id = group.id.uuidString
        name = group.name
        emails = group.emails.map{$0.toString()}
    }
}
