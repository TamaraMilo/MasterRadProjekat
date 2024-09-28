//
//  TrainerView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import SwiftUI

struct TrainerView: View {
    var trainer: Trainer
    
    var body: some View {
        Text(trainer.fistName)
        Text(trainer.lastName)
        trainingsView
        Text(trainer.biography)
    }
    
    var trainingsView: some View {
        ForEach(trainer.trainings) { training in
            Text(training.name)
        }
    }
}

#Preview {
//    TrainerView()
}
