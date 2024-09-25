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
    var email: String
    var age: String
    
    var username: String
    
    init(id: String, firstName: String, lastName: String, email: String, username: String, age: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
        self.age = age
    }
    
    init() {
        id = ""
        firstName = ""
        lastName = ""
        email = ""
        username = ""
        age = ""
    }
}
