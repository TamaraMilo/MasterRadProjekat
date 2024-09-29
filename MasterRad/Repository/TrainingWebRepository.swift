//
//  TrainingWebRepository.swift
//  MasterRad
//
//  Created by Tamara Milovanovic on 29.9.24..
//

import SwiftUI
import Combine
import FirebaseDatabase


protocol TrainingRepository {
    var ref: DatabaseReference { get }
    func createTraining(name: String, date: String, time: String, trainer: String, description: String)
    func getTraining(id: String) -> AnyPublisher<Training?, Error>
    func getTrainings() -> AnyPublisher<[Training], Error>
    func removeTraining(id: String)
}

class TrainingWebRepository: TrainingRepository {
    var ref: DatabaseReference = Database.database().reference()

    func createTraining(name: String, date: String, time: String, trainer: String, description: String) {
        let id = UUID().uuidString
        ref.child("trainings")
            .child(id)
            .setValue(
                [
                    "id": id,
                    "name": name,
                    "date": date,
                    "time": time,
                    "trainer": trainer,
                    "description": description
                ]
            )
    }
    
    func getTraining(id: String) -> AnyPublisher<Training?, any Error> {
        let subject = CurrentValueSubject<Training?, Error>(Training())

        let handle = ref.child("trainings").child(id).observe(.value, with: { snapshot in
            let json = snapshot.value as! [String: Any]
            
            let training = try? JSONDecoder().decode(Training.self, from: JSONSerialization.data(withJSONObject: json))
            subject.send(training)

        })
        
        return subject.handleEvents(receiveCancel: {[weak self] in
                    self?.ref.removeObserver(withHandle: handle)
        }).eraseToAnyPublisher()
        
    }
    
    func getTrainings() -> AnyPublisher<[Training], any Error> {
        let subject = CurrentValueSubject<[Training], Error>([])
        var trainings:[Training] = []
        let handle = ref.child("trainings").observe(.value, with: { snapshot in
                
            let data = snapshot.value as! NSDictionary
            let keys = data.allKeys
            
            keys.forEach { key in
                do {
                    let trainingData = data[key]
                    let trainingJson = try JSONSerialization.data(withJSONObject: trainingData)
                    let trainingW = try JSONDecoder().decode(TrainingW.self, from: trainingJson)
                    let participantsDataedw = trainingData as! NSDictionary
                    let participantsData = participantsDataedw["participants"]
                    let participantsJson = try JSONSerialization.data(withJSONObject: participantsData)
                    let participants = try JSONDecoder().decode([UserData].self, from: trainingJson)
                    
                    var traingno = Training()
                    traingno.id = trainingW.id
                    traingno.name = trainingW.name
                    traingno.date = trainingW.date
                    traingno.time = trainingW.time
                    traingno.description = trainingW.description
                    traingno.trainer = trainingW.trainer
                    traingno.participants = participants
                    

                    
                    trainings.append(traingno)
                } catch {
                    print("Error")
                }
            }
            
            
        })
        
        subject.send(trainings)
        return subject.handleEvents(receiveCancel: {[weak self] in
                    self?.ref.removeObserver(withHandle: handle)
        }).eraseToAnyPublisher()
    }
    
    func removeTraining(id: String) {
        ref.child("trainings").child(id).removeValue()
    }
    
    
}



