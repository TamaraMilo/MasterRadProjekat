//
//  LoginDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation

protocol LoginInjectable {
    var rootEventTracker: RootEventTracker { get set }
    var webRepository: AuthRepository { get }

}

final class LoginDependency: LoginInjectable {
    var rootEventTracker: RootEventTracker
    var webRepository: AuthRepository
    
    init(webRepository: AuthRepository, rootEventTracker: RootEventTracker) {
        self.rootEventTracker = rootEventTracker
        self.webRepository = webRepository
    }
}
