//
//  User.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation

struct UserData: Decodable {
    let id: Int
    var firstName: String
    var lastName: String
    var email: String
    var username: String
    
    init(id: Int, firstName: String, lastName: String, email: String, username: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.username = username
    }
    
    init() {
        id = 0
        firstName = ""
        lastName = ""
        email = ""
        username = ""
    }
}
