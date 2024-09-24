//
//  ProfileView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            userDataView
            logoutView
        }
    }
    
    var userDataView: some View {
        VStack {
            Text("First Name:\(viewModel.user.firstName)")
            Text("Last Name:\(viewModel.user.lastName)")
            Text("Email:\(viewModel.user.email)")
        }
    }
    
    var logoutView: some View {
        Button {
            viewModel.logout()
        } label: {
            Text("Logout")
        }
    }
}

#Preview {
    ProfileView(viewModel: ProfileViewModel(rootEventTracker: RootEventTracker()))
}
