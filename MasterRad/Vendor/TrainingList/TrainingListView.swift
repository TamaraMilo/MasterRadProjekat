//
//  TrainingListView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import SwiftUI

struct TrainingListView: View {
    @State private var startAnimation: Bool = false
    @ObservedObject var viewModel: TrainingListViewModel
    
    var body: some View {
        rootView
    }
    
    @ViewBuilder
    var rootView: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.fetchTrainings)
        case .loading:
            ProgressView()
        case .ready:
            readyView
        case .error:
            Color.red
        }
    }
    
    var readyView: some View {
        ZStack {
            backgroundView
            contentView
        }
    }
    
    var contentView: some View {
        VStack {
            headerView
            Spacer()
            trainingListView
            Spacer()
        }
    }
    
    var headerView: some View {
        Text("Training List")
            .font(.title)
    }
    
    var backgroundView: some View {
        LinearGradient( colors: [.blue, .green],
                        startPoint: startAnimation ? .topLeading : .bottomLeading,
                        endPoint: startAnimation ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
    }
    
    var trainingListView: some View {
        ScrollView {
            ForEach(viewModel.trainings) { training in
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Name \(training.name)")
                                .font(.title3)
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Delete")
                            }
                    }
                        Text("Time \(training.time)")
                        Text("Date \(training.date)")
                        Text("Description \(training.description)")
                        Text("Trainer Name \(training.trainer)")
                        makeParticipantsView(participants: training.participants)
                    }
                    .padding()
                    Spacer()
                }
                .background(fieldBackgroundView)
                .padding(.horizontal, 15)
                .font(.caption2)
            }
        }
    }
        
        func makeParticipantsView(participants: [UserData]) -> some View {
            VStack(alignment: .leading) {
                Text("Participants:")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                    ForEach(participants) { participant in
                        
                        Text(participant.firstName + " " + participant.lastName)
                        }
                    }
                }
            }
    }
    
    var fieldBackgroundView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.white)
            .stroke(.black.opacity(0.6))
    }
}

#Preview {
    TrainingListView(
        viewModel: TrainingListViewModel(
            trainingWebRepository: TrainingWebRepository()
        )
    )
}
