//
//  TrainingView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import SwiftUI

struct TrainingView: View {
    @EnvironmentObject var sharedData: SharedData
    var training: Training
    
    var body: some View {
        VStack {
            dateAndTimeView
            Text(training.name)
            trainerView
            participantsView
            plusButtonView
        }
    }
    
    var dateAndTimeView: some View {
        HStack {
            Text(training.date)
            Text(training.time)
        }
    }
    
    var trainerView: some View {
        Text(training.trainer.fistName)
            .onTapGesture {
                sharedData.navigate(destination: .trainer)
            }
    }
    
    var descriptionView: some View {
        Text(training.description)
    }
    
    var participantsView: some View {
        ForEach(training.participants) { user in
            Text(user.firstName)
        }
    }
    
    var plusButtonView: some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
        }

    }
}

#Preview {
//    TrainingView(training: Training(id: 1, name: "", date: "", trainer: Trainer()))
}
