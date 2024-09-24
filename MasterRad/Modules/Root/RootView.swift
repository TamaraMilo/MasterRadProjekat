//
//  RootView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    let loginCoordinator: any LoginCoordinable
    let applicationCoordinator: any ApplicationCoordinable
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: { viewModel.checkAuthentication()})
        case .login:
            loginCoordinator.view
        case .register:
            EmptyView()
        case .application:
            applicationCoordinator.view
        }
    }
}

#Preview {
    RootView(
        viewModel: RootViewModel(authWebRepository: AuthWebRepository(), rootEventTracker: RootEventTracker()),
        loginCoordinator: LoginCoordinator(
            dependency: LoginDependency(
                webRepository: AuthWebRepository(),
                rootEventTracker: RootEventTracker()
            )
        ),
        applicationCoordinator: ApplicationCoordinator(
            dependency: ApplicationDependency(rootEventTracker: RootEventTracker())
        )
    )
}
