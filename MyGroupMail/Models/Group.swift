//
//  Group.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation

public struct Group: Identifiable, Equatable {
    public var id = UUID()
    var name = ""
    var emails: [Email] = []
    var groupId = ""
}

