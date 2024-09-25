//
//  ApplicationView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import SwiftUI

struct ApplicationView: View {
    @ObservedObject var viewModel: ApplicationViewModel
    @EnvironmentObject var sharedData: SharedData
    var coordinator: any ApplicationCoordinable
    @State var training: Training?
    @State var trainer: Trainer?
    
    var body: some View {
        NavigationStack(path: $sharedData.navigationPath) {
            rootView
                .navigationDestination(for: SharedData.NavigationStates.self ) { state in
                    switch state {
                    case .profile:
                        profileView
                    case .trainer:
                        trainerView
                    case .training:
                        trainingView
                    }
                }
        }
    }
    
    var rootView: some View {
        VStack {
            headerView
            trainingDescriptionView
        }
    }
    
    var profileView: some View {
        coordinator.profileCoordinator.view
    }
    
    @ViewBuilder
    var trainerView: some View {
        if let trainer {
            coordinator.makeTrainerCoordinator(trainer: trainer).view
        }
    }
    
    @ViewBuilder
    var trainingView: some View {
        if let training {
            coordinator.makeTrainingCoordinator(training: training).view
        }
    }
}

// MARK: Header

extension ApplicationView {
    var headerView: some View {
        HStack {
            Text("Cross gym")
            profileButtonView
        }
    }
    
    var profileButtonView: some View {
        Button {
            sharedData.navigate(destination: .profile)
        } label: {
            Image(systemName: "brain.head.profile")
        }
    }
}

// MARK: Header

extension ApplicationView {
    var trainingDescriptionView: some View {
        TabView(selection: $viewModel.currentTab) {
            ForEach(viewModel.trainings) { training in
                VStack {
                    Text("Naziv: \(training.name)")
                    Text("Date: \(training.date)")
                    Text("Trener: \(training.trainer)")
                }
                .tag(training.id)
                .onTapGesture {
                    self.training = training
                    self.trainer = training.trainer
                    sharedData.navigate(destination: .training)
                }
            }
        }
        .id(viewModel.currentTab)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}



#Preview {
    ApplicationView(
        viewModel: ApplicationViewModel(rootEventTracker: RootEventTracker()),
        coordinator: ApplicationCoordinator(
            dependency: ApplicationDependency(
                rootEventTracker: RootEventTracker()
            )
        )
    )
}
