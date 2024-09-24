//
//  ApplicationCoordinator.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import Foundation
import SwiftUI

protocol ApplicationCoordinable: Coordinable {
    
}

class ApplicationCoordinator<Dependency> where Dependency: ApplicationDependency {
    var dependency: Dependency

    init(dependency: Dependency) {
        self.dependency = dependency
    }
    
    var view: AnyView {
        AnyView(
            ApplicationView(viewModel: ApplicationViewModel(rootEventTracker: dependency.rootEventTracker))
        )
    }
}

extension ApplicationCoordinator: ApplicationCoordinable {
    
}
