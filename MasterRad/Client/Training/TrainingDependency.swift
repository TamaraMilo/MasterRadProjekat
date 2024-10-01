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
    var trainingId: String { get }
}

final class TrainingDependency: TrainingInjectable {

    var userWebRepository: UserRepository
    var authWebRepository: AuthRepository
    var trainingId: String

    init(
        authWebRepository: AuthRepository,
        userWebRepository: UserRepository,
        trainingId: String
    ) {
        self.authWebRepository = authWebRepository
        self.userWebRepository = userWebRepository
        self.trainingId = trainingId
    }
}
