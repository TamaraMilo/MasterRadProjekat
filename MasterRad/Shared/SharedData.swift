//
//  SharedData.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import Foundation
import SwiftUI

enum AppState: Hashable {
    
    enum Initial {
        case root
        case login
        case application
    }

    case idle
    case initial(Initial)
}

class SharedData: ObservableObject {
    @Published var appState: AppState = AppState.initial(.root)
    @Published var navigationPath = NavigationPath()
    
    enum NavigationStates: Hashable {
        case training
        case trainer
        case profile
    }
    
    func navigate(destination: NavigationStates) {
        navigationPath.append(destination)
    }
    
    func popChild() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast(1)
        }
    }
}
