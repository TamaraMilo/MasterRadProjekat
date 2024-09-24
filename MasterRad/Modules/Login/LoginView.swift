//
//  LoginView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        rootView
    }
    
    var rootView: some View {
        VStack {
            textfieldViews
            loginButtonView
            registerButtonView
        }
    }
    var textfieldViews: some View {
        VStack {
//            TextField("Username", text: $viewModel.user.username)
//            TextField("Password", text: $viewModel.user.firstName)
        }
    }
    
    var loginButtonView: some View {
        Button {
            viewModel.signIn()
        } label: {
            Text("Login")
        }
    }
    
    var registerButtonView: some View {
        Button {
            
        } label: {
            Text("Register")
        }

    }
    
}

#Preview {
    LoginView(viewModel: LoginViewModel(webRepository: AuthWebRepository(), rootEventTracker: RootEventTracker()))
}
