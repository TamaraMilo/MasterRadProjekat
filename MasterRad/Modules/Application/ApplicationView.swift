//
//  ApplicationView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import SwiftUI

struct ApplicationView: View {
    @ObservedObject var viewModel: ApplicationViewModel
    
    var body: some View {
        VStack {
            headerView
            trainingDescriptionView
        }
    }
}

// MARK: Header

extension ApplicationView {
    var headerView: some View {
        HStack {
            Text("Cross gym")
            Button {
                // Profile
            } label: {
                Image(systemName: "dot")
            }
        }
    }
}

// MARK: Header

extension ApplicationView {
    var trainingDescriptionView: some View {
        VStack {
            Text("Naziv")
            Text("Date")
            Text("Trener")
        }
    }
}

#Preview {
    ApplicationView(viewModel: ApplicationViewModel(rootEventTracker: RootEventTracker()))
}
