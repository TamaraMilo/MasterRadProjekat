//
//  TrainingView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import SwiftUI

struct TrainingView: View {
    
    @ObservedObject var viewModel: TreningViewModel
    @EnvironmentObject var sharedData: SharedData
    @State private var startAnimation: Bool = false

    
    var body: some View {
        rootView
        .onAppear {
            withAnimation(.linear(duration: 5.0).repeatForever()) {
                startAnimation.toggle()
            }
        }
    }
    
    @ViewBuilder
    var rootView: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear(perform: viewModel.fetchUserData)
        case .loading:
            ProgressView()
        case .ready:
            readyView
        case .error:
            Color.red
        }
    }
    
    var readyView: some View {
        ZStack(alignment: .bottomTrailing) {
            backgroundView
                .ignoresSafeArea()
            contentView
            plusButtonView
        }
        .onAppear {
            withAnimation(.linear(duration: 5.0).repeatForever()) {
                startAnimation.toggle()
            }
        }
    }
    
    var contentView: some View {
        VStack(alignment: .leading) {
            dateAndTimeView
            trainingNameView
            trainerView
            descriptionView
            participantsView
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    var backgroundView: some View {
        LinearGradient( colors: [.purple, .blue],
                        startPoint: startAnimation ? .topLeading : .bottomLeading,
                        endPoint: startAnimation ? .bottomTrailing : .topTrailing
        )
    }
    
    var dateAndTimeView: some View {
        VStack(alignment: .leading) {
//            dateView
            timeView
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    
    var dateView: some View {
        HStack {
            Text("Date: ")
                .font(.title)
            Text(viewModel.training.date)
                .font(.title)
            Spacer()
        }
    }
    
    var timeView: some View {
        HStack {
            Text("Time:")
                .font(.title)
            Text(viewModel.training.time)
                .font(.title)
            Spacer()
            
        }
    }
    
    
    var trainerView: some View {
        HStack {
            Text("Trener: ")
                .font(.headline)
            HStack {
                Text(viewModel.training.trainer)
                    .font(.headline)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    
    var descriptionView: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("Trening u planu:")
                    .font(.title2)
                Divider()
                Text(viewModel.training.description)
                    .font(.headline)
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
        
    }
    
    var trainingNameView: some View {
        HStack {
            Text("Trening: ")
                .font(.title2)
            Text(viewModel.training.name)
                .font(.title2)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    
    var participantsView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Samo najhrabriji ucestvuju: ")
                .font(.title2)
            Divider()
            ScrollView {
                ForEach(viewModel.training2.participants) { user in
                    HStack {
                        Text(user.firstName)
                            .font(.headline)
                        Text(user.lastName)
                            .font(.headline)
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 12).fill(.white))
    }
    
    var plusButtonView: some View {
        if viewModel.isAlreadyInTraining {
            Button(action: viewModel.removeUserFromTraining) {
                Image(systemName: "minus")
                    .frame(width: 50, height: 50)
                    .background(Circle().fill(.white).shadow(color: .purple, radius: 1))
            }
            .padding(.all, 20)
        } else {
            Button(action: viewModel.addUserToTrain) {
                Image(systemName: "plus")
                    .frame(width: 50, height: 50)
                    .background(Circle().fill(.white).shadow(color: .purple, radius: 1))
            }
            .padding(.all, 20)
        }
       

    }
}

#Preview {
//    TrainingView(training: Training(id: 1, name: "", date: "", trainer: Trainer()))
}
