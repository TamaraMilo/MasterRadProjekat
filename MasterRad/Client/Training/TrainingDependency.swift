//
//  TrainingDependency.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
import SwiftUI

protocol TrainingInjectable {
    var userWebRepository: UserRepository { get }
    var authWebRepository: AuthRepository { get }
}

final class TrainingDependency: TrainingInjectable {

    var userWebRepository: UserRepository
    var authWebRepository: AuthRepository

    init(
        authWebRepository: AuthRepository,
        userWebRepository: UserRepository
    ) {
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
    }
}
