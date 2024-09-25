//
//  ProfileView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 24.9.24..
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    @State var isPasswordShowing: Bool = false
    @State var isRepeatPasswordShowing: Bool = false
    
    var body: some View {
        rootView
    }
    
    @ViewBuilder
    var rootView: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.task {
                await viewModel.fetchUserData()
            }
        case .loading:
            ProgressView()
        case .ready:
            readyView
        case .error:
            Color.red
        }
    }
    
    var readyView: some View {
        VStack(spacing: 5) {
            Image(.crossGymHighResolutionLogoTransparent1)
                .resizable()
                .frame(width: 100, height: 100)
            nameView
            surnameView
            ageView
            changeDataView
            passwordsView
            signOutButtonView
            Spacer()
        }
        .padding(.horizontal, 16)
        .toolbar {
            Button(action: viewModel.processEditMode) {
                Text(viewModel.editMode ? "Close" : "Edit")
            }
        }
    }
    
    @ViewBuilder
    var nameView: some View {
        if viewModel.editMode {
            nameTextFieldView
        } else {
            nameTextView
        }
    }
    
    @ViewBuilder
    var surnameView: some View {
        if viewModel.editMode {
            surnameTextFieldView
        } else {
            surnameTextView
        }
    }
    
    @ViewBuilder
    var ageView: some View {
        if viewModel.editMode {
            ageTextFieldView
        } else {
            ageTextView
        }
    }
    
    var nameTextView: some View {
        HStack(spacing: 10) {
            Text("Name: ")
                .foregroundStyle(.gray)
                .font(.headline)
            
            Text(viewModel.user.firstName)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(fieldBackgroundView)
    }
    
    var surnameTextView: some View {
        HStack(spacing: 10) {
            Text("Surname: " )
                .foregroundStyle(.gray)
                .font(.headline)
            
            Text(viewModel.user.lastName)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(fieldBackgroundView)
    }
    
    var ageTextView: some View {
        HStack(spacing: 10) {
            Text("Age:" )
                .foregroundStyle(.gray)
                .font(.headline)
         
            Text(viewModel.user.age)
                .font(.headline)
            
            Spacer()
        }
        .padding()
        .background(fieldBackgroundView)
    }
    
    var nameTextFieldView: some View {
        TextField("Name", text: $viewModel.user.firstName)
            .padding()
            .background(fieldBackgroundView)
    }
    
    var surnameTextFieldView: some View {
        TextField("Surname", text: $viewModel.user.lastName)
            .padding()
            .background(fieldBackgroundView)
    }
    
    var ageTextFieldView: some View {
        TextField("Age", text: $viewModel.user.age)
            .keyboardType(.numberPad)
            .padding()
            .background(fieldBackgroundView)
    }
    
    @ViewBuilder
    var changeDataView: some View {
        if viewModel.editMode {
            Button(action: viewModel.updateUserData) {
                HStack {
                    Spacer()
                    Text("Change Data")
                        .foregroundStyle(.purple)
                    Spacer()
                }
                .padding(.vertical, 16)
                .background(fieldBackgroundView)
            }
        }
    }
    
    var signOutButtonView: some View {
        Button(action: viewModel.logout) {
            HStack {
                Spacer()
                Text("Sign out")
                    .foregroundStyle(.purple)
                Spacer()
            }
            .padding(.vertical, 16)
            .background(fieldBackgroundView)
        }
    }
    
    var fieldBackgroundView: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(.purple.opacity(0.6))
    }
    
    @ViewBuilder
    var passwordsView: some View {
        if viewModel.editMode {
            VStack(spacing: 5) {
                passwordView
                repeatPasswordView
                changePasswordView
            }
        }
    }
    
    @ViewBuilder
    var passwordView: some View {
        if isPasswordShowing {
            passwordTextFieldView
        } else {
            hiddenPasswordView
        }
    }
    
    var hiddenPasswordView: some View {
        HStack {
            SecureField(
                "Password",
                text: $viewModel.newPassword
            )
            .padding()
            .foregroundStyle(.black)
            .background(fieldBackgroundView)
            
            Spacer()
            
            Image(systemName: "eye.fill")
                .onTapGesture {
                    isPasswordShowing = true
                }
        }
    }
    
    var passwordTextFieldView: some View {
        HStack {
            TextField(
                "Password",
                text: $viewModel.newPassword
            )
            .foregroundStyle(.black)
            .background(fieldBackgroundView)
            
            Spacer()
            
            Image(systemName: "eye.slash.fill")
                .onTapGesture {
                    isPasswordShowing = false
                }
        }
    }

    @ViewBuilder
    var repeatPasswordView: some View {
        if isRepeatPasswordShowing {
            passwordRepeatTextFieldView
        } else {
            hiddenRepeatPasswordView
        }
    }
    
    var hiddenRepeatPasswordView: some View {
        HStack {
            SecureField(
                "Repeat password",
                text: $viewModel.repeatNewPassword
            )
            .padding()
            .foregroundStyle(.black)
            .background(fieldBackgroundView)
            
            Spacer()
            
            Image(systemName: "eye.fill")
                .onTapGesture {
                    isPasswordShowing = true
                }
        }
    }
    
    var passwordRepeatTextFieldView: some View {
        HStack {
            TextField(
                "Repeat password",
                text: $viewModel.repeatNewPassword
            )
            .foregroundStyle(.black)
            .background(fieldBackgroundView)
            
            Spacer()
            
            Image(systemName: "eye.slash.fill")
                .onTapGesture {
                    isPasswordShowing = false
                }
        }
    }

    
    var changePasswordView: some View {
        Button(action: viewModel.changePassword) {
            HStack {
                Spacer()
                Text("Change Password")
                    .foregroundStyle(.purple)
                Spacer()
            }
            .padding(.vertical, 16)
            .background(fieldBackgroundView)
        }
    }
}

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(
            userWebRepository: UserWebRepository(),
            authWebRepository: AuthWebRepository(),
            rootEventTracker: RootEventTracker()
        )
    )
}
