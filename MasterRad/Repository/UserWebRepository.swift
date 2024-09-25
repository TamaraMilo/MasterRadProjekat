//
//  UserWebRepository.swift
//  MasterRad
//
//  Created by Tamara Milovanovic on 24.9.24..
//

import Foundation
import FirebaseDatabase

protocol UserRepository {
    var ref: DatabaseReference { get }
    func getUserData(id: String) async -> UserData?
    func createUser(id: String, name: String, surname: String, age: String)
    func updateUserData(userData: UserData)
}

class UserWebRepository: UserRepository {
    var ref: DatabaseReference = Database.database().reference()

    func getUserData(id: String) async -> UserData? {
        do {
            let data = try await ref.child("users").child(id).getData()
            
            let json = data.value as! [String: Any]
            
            let userData = try? JSONDecoder().decode(UserData.self, from: JSONSerialization.data(withJSONObject: json))
            
            return userData
        } catch {
            return nil
        }
    }
    
    func createUser(id: String, name: String, surname: String, age: String) {
        ref.child("users")
            .child(id)
            .setValue(
                [
                    "id": id,
                    "firstName": name,
                    "lastName": surname,
                    "age": age
                ]
            )
    }
    
    func updateUserData(userData: UserData) {
        let updatedValues =  [
            "id": userData.id,
            "firstName": userData.firstName,
            "lastName": userData.lastName,
            "age": userData.age
        ]
        ref.child("users").child(userData.id)
            .setValue(updatedValues)
    }
}
