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
            Text("Application")
            Button {
                viewModel.logout()
            } label: {
                Text("Logout")
            }

        }
    }
}

#Preview {
    ApplicationView(viewModel: ApplicationViewModel(rootEventTracker: RootEventTracker()))
}
