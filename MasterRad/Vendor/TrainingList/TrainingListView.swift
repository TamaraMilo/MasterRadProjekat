//
//  TrainingListView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import SwiftUI

struct TrainingListView: View {
    @State private var startAnimation: Bool = false
    @ObservedObject var viewModel: TrainingListViewModel = TrainingListViewModel()
    
    var body: some View {
        ZStack {
            backgroundView
            rootView
        }
    }
    
    var rootView: some View {
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
        ForEach(viewModel.trainings) { training in
            Text(training.name)
                .font(.caption)
            
        }
    }
    
    var fieldBackgroundView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.white)
            .stroke(.black.opacity(0.6))
    }
}

#Preview {
    TrainingListView()
}
