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
    func signIn(password: String, email: String) -> AnyPublisher<User, Error>
}

class AuthWebRepository: AuthRepository {
    var ref: DatabaseReference = Database.database().reference()
    
    func signIn(password: String, email: String) -> AnyPublisher<User, Error> {
        Auth.auth().signIn(withEmail: email, password: password)
            .map{ $0.user }
            .eraseToAnyPublisher()
    }
    
    
}
