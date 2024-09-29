//
//  VendorSharedData.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import Foundation
import SwiftUI

class VendorSharedData: ObservableObject {
    @Published var appState: AppState = AppState.initial(.root)
    @Published var navigationPath = NavigationPath()
    
    enum NavigationStates: Hashable {
        case createTraining
        case trainingList
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
