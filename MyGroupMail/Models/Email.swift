//
//  Email.swift
//  MyGroupMail
//
//  Created by Kevin Renata on 25/07/23.
//

import Foundation

public struct Email: Identifiable, Equatable {
    public let id = UUID()
    let name: String
    var isChecked = false
}

extension Email: Hashable{
    mutating func setChecked(checked: Bool){
        isChecked = checked
    }
    
    func toString() -> String{
        return name
    }
}

