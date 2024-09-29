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
    
    @State private var startAnimation: Bool = false
    @State var training: Training = Training()
    
    var body: some View {
        NavigationStack(path: $sharedData.navigationPath) {
            rootView
                .navigationDestination(for: SharedData.NavigationStates.self ) { state in
                    switch state {
                    case .profile:
                        profileView
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
        .background(backgroundView)
        .onAppear {
            withAnimation(.linear(duration: 5.0).repeatForever()) {
                startAnimation.toggle()
            }
        }
    }
    
    var profileView: some View {
        coordinator.profileCoordinator.view
    }
    
    @ViewBuilder
    var trainingView: some View {
        coordinator.makeTrainingCoordinator(training: $training).view
    }
    
    var backgroundView: some View {
        LinearGradient( colors: [.purple, .blue],
                        startPoint: startAnimation ? .topLeading : .bottomLeading,
                        endPoint: startAnimation ? .bottomTrailing : .topTrailing
                    )
        .ignoresSafeArea()
    }
}

// MARK: Header

extension ApplicationView {
    var headerView: some View {
        HStack(alignment: .center) {
            Image(.crossGymHighResolutionLogoTransparent1)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)

            Text("Cross gym")
                .font(.headline)
                .foregroundStyle(.white)
            Spacer()
            profileButtonView
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    
    var profileButtonView: some View {
        Button {
            sharedData.navigate(destination: .profile)
        } label: {
            Image(systemName: "brain.head.profile")
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(.white)
                .frame(width: 25, height: 25)
        }
    }
}

// MARK: Header

extension ApplicationView {
    var trainingDescriptionView: some View {
        TabView(selection: $viewModel.currentTab) {
            ForEach(viewModel.days) { day in
                VStack(spacing: 30) {
                    Text(day.name)
                        .foregroundStyle(.white)
                        .font(.title)
                        .padding(.vertical, 20)
                    makeTrainingDescription(trainings: viewModel.trainings.filter({ $0.date == day.date}))
                }
                .tag(day.id)
            }
        }
        .id(viewModel.currentTab)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    func makeTrainingDescription(trainings: [Training]) -> some View {
        ScrollView {
            ForEach(trainings) { training in
                VStack {
                    Text("Naziv: \(training.name)")
                    Text("Vreme: \(training.time)")
                    Text("Trener: \(training.trainer)")
                }
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
                .onTapGesture {
                    self.training = training
                    sharedData.navigate(destination: .training)
                }
            }
        }
    }
    
}



#Preview {
    ApplicationView(
        viewModel: ApplicationViewModel(
            rootEventTracker: RootEventTracker(),
            trainingWebRepository: TrainingWebRepository()
        ),
        coordinator: ApplicationCoordinator(
            dependency: ApplicationDependency(
                rootEventTracker: RootEventTracker(),
                userWebRepository: UserWebRepository(),
                authWebRepository: AuthWebRepository(),
                trainingWebRepository: TrainingWebRepository()
            )
        )
    )
}
