//
//  CreateTrainingView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 28.9.24..
//

import SwiftUI

struct CreateTrainingView: View {
    @State private var startAnimation: Bool = false
    @ObservedObject var viewModel: CreateTrainingViewModel
    var body: some View {
        rootView
            .onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
            .background(backgroundView)
    }
    
    var rootView: some View {
        ScrollView {
            VStack(spacing: 20) {
                headerView
                Spacer()
                dateView
                nameView
                timeView
                descriptionView
                trainerView
                createButtonView
                Spacer()
            }
        }
        .padding(.horizontal, 15)
    }
    
    var headerView: some View {
        Text("Create training")
            .font(.title)
    }
    
    var backgroundView: some View {
        LinearGradient( colors: [.blue, .green],
                        startPoint: startAnimation ? .topLeading : .bottomLeading,
                        endPoint: startAnimation ? .bottomTrailing : .topTrailing
        )
        .ignoresSafeArea()
    }
    
    var fieldBackgroundView: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(.white)
            .stroke(.black.opacity(0.6))
    }
}

extension CreateTrainingView {
    var dateView: some View {
        VStack(alignment: .leading) {
            Text("Date")
            TextField("Date", text: $viewModel.training.date)
                .padding()
                .background(fieldBackgroundView)
        }
    }
    
    var nameView: some View {
        VStack(alignment: .leading) {
            Text("Name")
            TextField("Name", text: $viewModel.training.name)
                .padding()
                .background(fieldBackgroundView)
        }
    }
    
    var timeView: some View {
        VStack(alignment: .leading) {
            Text("Time")
            TextField("Time", text: $viewModel.training.time)
                .padding()
                .background(fieldBackgroundView)
        }
    }
    
    var descriptionView: some View {
        VStack(alignment: .leading) {
            Text("Description")
            TextField("Description", text: $viewModel.training.description)
                .padding()
                .background(fieldBackgroundView)
        }
    }
    
    var trainerView: some View {
        VStack(alignment: .leading) {
            Text("Trainer")
            TextField("Trainer", text: $viewModel.training.trainer)
                .padding()
                .background(fieldBackgroundView)
        }
    }
    
    var createButtonView: some View {
        Button {
            viewModel.createTraining()
        } label: {
            Text("Create Training")
                .foregroundStyle(.gray)
                .padding()
                .background(fieldBackgroundView)
        }

    }
}

#Preview {
    CreateTrainingView(viewModel: CreateTrainingViewModel())
}
