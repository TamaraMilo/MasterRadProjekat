//
//  AuthWebRepository.swift
//  MasterRad
//
//  Created by Tamara Milovanovic on 24.9.24..
//

import Foundation
import FirebaseDatabase
import FirebaseAuthCombineSwift
import FirebaseAuth
import Combine

protocol AuthRepository {
    var ref: DatabaseReference { get }
    var user: User? { get }
    var isUserLoggedIn: Bool { get }
    func signIn(password: String, email: String) -> AnyPublisher<User, Error>
    func signUp(with email: String, password: String) -> AnyPublisher<User, Error>
    func changePassword(newPassword: String)
    func signOutUser()

}

class AuthWebRepository: AuthRepository {
    var ref: DatabaseReference = Database.database().reference()
    
    func signIn(password: String, email: String) -> AnyPublisher<User, Error> {
        Auth.auth().signIn(withEmail: email, password: password)
            .map{ $0.user }
            .eraseToAnyPublisher()
    }
    
    func signUp(with email: String, password: String) -> AnyPublisher<User, Error> {
        Auth.auth().createUser(withEmail: email, password: password)
            .map{ $0.user }
            .eraseToAnyPublisher()
    }
    func changePassword(newPassword: String) {
        Auth.auth().currentUser?.updatePassword(to: newPassword)
    }
    
    func signOutUser() {
        try? Auth.auth().signOut()
    }
    
    var user: User? {
        Auth.auth().currentUser
    }
    
    var isUserLoggedIn: Bool {
        Auth.auth().currentUser?.uid != nil
    }
}
