//
//  VendorView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import SwiftUI

struct VendorView: View {
    
    @State private var startAnimation: Bool = false
    @EnvironmentObject var sharedData: VendorSharedData
    @ObservedObject var viewModel: VendorViewModel
    
    var coordinator: any VendorCoordinable
    
    var body: some View {
        NavigationStack(path: $sharedData.navigationPath) {
            rootView
                .navigationDestination(for: VendorSharedData.NavigationStates.self) { state in
                    switch state {
                    case .createTraining:
                        createTrainingView
                    case .trainingList:
                        trainingListView
                    }
                }
        }
    }
    
    var rootView: some View {
        ZStack {
            backgroundView
            VStack(spacing: 20) {
                headerView
                Spacer()
                createTrainingButtonView
                trainingListButtonView
                Spacer()
            }
            .onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
        }
    }
    
    var createTrainingView: some View {
        coordinator.createTrainingCoordinator.view
    }
    
    var trainingListView: some View {
        coordinator.trainingListCoordinator.view
    }
    
    var backgroundView: some View {
        LinearGradient( colors: [.blue, .green],
                        startPoint: startAnimation ? .topLeading : .bottomLeading,
                        endPoint: startAnimation ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
    }
    
}

// MARK: Header

extension VendorView {
    var headerView: some View {
        HStack(alignment: .center) {
            Spacer()
            logoView
                .padding(.leading, 50)
            Spacer()
            logoutButtonView
        }
        .padding(.top, 10)
        .padding(.horizontal, 15)
    }
    
    var logoView: some View {
        Image(.crossGymHighResolutionLogoTransparent1)
            .renderingMode(.template)
            .resizable()
            .foregroundStyle(.white)
            .frame(width: 50, height: 50)
    }
    
    var logoutButtonView: some View {
        Button {
            viewModel.logout()
        } label: {
            Text("Logout ")
                .foregroundStyle(.white)
        }
    }
}


// MARK: Buttons

extension VendorView {
    var createTrainingButtonView: some View {
        Button {
            sharedData.navigate(destination: .createTraining)
        } label: {
            Text("Dodaj trening")
                .frame(
                    width: UIScreen.main.bounds.width * 0.9,
                    height: UIScreen.main.bounds.height * 0.1
                )
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .frame(
                            width: UIScreen.main.bounds.width * 0.9,
                            height: UIScreen.main.bounds.height * 0.1
                        )
                )
        }
        
    }
    
    var trainingListButtonView: some View {
        Button {
            sharedData.navigate(destination: .trainingList)
        } label: {
            Text("Lista treninga")
                .frame(
                    width: UIScreen.main.bounds.width * 0.9,
                    height: UIScreen.main.bounds.height * 0.1
                )
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(.white)
                        .frame(
                            width: UIScreen.main.bounds.width * 0.9,
                            height: UIScreen.main.bounds.height * 0.1
                        )
                )
        }
    }
}

#Preview {
    VendorView(
        viewModel: VendorViewModel(
            authWebRepository: AuthWebRepository(),
            rootEventTracker: RootEventTracker()
        ), coordinator: VendorCoordinator(
            dependency: VendorDependency(
                sharedData: VendorSharedData(),
                rootEventTracker: RootEventTracker(),
                authWebRepository: AuthWebRepository(),
                trainingWebRepository: TrainingWebRepository()
            )
        )
    )
}
