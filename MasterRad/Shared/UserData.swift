//
//  User.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

struct UserData: Decodable, Identifiable {
    let id: String
    var firstName: String
    var lastName: String
    var age: String
    var role: String
        
    init(id: String, firstName: String, lastName: String, age: String, role: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.role = role
    }
    
    init() {
        id = ""
        firstName = ""
        lastName = ""
        age = ""
        role = ""
    }
}
