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
    let registerCoordinator: any RegisterCoordinable
    let applicationCoordinator: any ApplicationCoordinable
    let vendorCoordinator: any VendorCoordinable
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: { viewModel.checkAuthentication()})
        case .login:
            loginCoordinator.view
        case .register:
            registerCoordinator.view
        case .application:
            applicationCoordinator.view
        case .vendor:
            vendorCoordinator.view
        }
    }
}

#Preview {
    RootView(
        viewModel: RootViewModel(
            authWebRepository: AuthWebRepository(),
            userWebRepository: UserWebRepository(),
            rootEventTracker: RootEventTracker()
        ),
        loginCoordinator: LoginCoordinator(
            dependency: LoginDependency(
                webRepository: AuthWebRepository(),
                rootEventTracker: RootEventTracker()
            )
        ),
        registerCoordinator: RegisterCoordinator(
            dependency: RegisterDependency(
                rootEventTracker: RootEventTracker(),
                authWebRepository: AuthWebRepository(),
                userWebRepository: UserWebRepository()
            )
        ),
        applicationCoordinator: ApplicationCoordinator(
            dependency: ApplicationDependency(
                rootEventTracker: RootEventTracker(),
                userWebRepository: UserWebRepository(),
                authWebRepository: AuthWebRepository()
            )
        ),
        vendorCoordinator: VendorCoordinator(dependency: VendorDependency(sharedData: VendorSharedData()))
    )
}
