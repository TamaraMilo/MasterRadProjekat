//
//  LoginView.swift
//  MasterRad
//
//  Created by Ivan Maksimovic on 23.9.24..
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    @State private var isPasswordShowing: Bool = false
    @State private var startAnimation: Bool = false

    var body: some View {
        rootView
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Error logging"), message: Text(viewModel.alertText), dismissButton: .default(Text("Cancel")) )
            }
    }
    
    var rootView: some View {
        VStack(alignment: .center, spacing: 18) {
            crossGymIconView
            Spacer()
            emailTextFieldView
            passwordView
            singUpTextView
            Spacer()
            singInButtonView
        }
        .padding()
        .background(backgroundView)
    }
    
    var crossGymIconView: some View {
        Image(.crossGymHighResolutionLogoTransparent1)
            .resizable()
            .foregroundStyle(.black)
            .frame(width: 250,height: 250)
            .padding(.top, 80)
    }
    
    var emailTextFieldView: some View {
        TextField("Email", text: $viewModel.email)
            .keyboardType(.emailAddress)
            .padding()
            .foregroundStyle(.black)
            .background(fieldBackgroundView)
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
            SecureField("Password", text: $viewModel.password)
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
            TextField("Password", text: $viewModel.password)
                .padding()
                .foregroundStyle(.black)
                .background(fieldBackgroundView)
            
            Spacer()
            
            Image(systemName: "eye.slash.fill")
                .onTapGesture {
                    isPasswordShowing = false
                }
        }
    }
    
    var singUpTextView: some View {
        Text("Don't have account? Sign up!")
            .foregroundStyle(.black)
            .onTapGesture(perform: viewModel.openRegisterView)
    }
    
    var backgroundView: some View {
        LinearGradient( colors: [.purple, .blue],
                        startPoint: startAnimation ? .topLeading : .bottomLeading,
                        endPoint: startAnimation ? .bottomTrailing : .topTrailing
                    )
    }
    
    var fieldBackgroundView: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(.black.opacity(0.6))
    }
    
    var singInButtonView: some View {
        Button(action: viewModel.signIn) {
            HStack {
                Spacer()
                Text("Sign In")
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.vertical, 12)
        }
        .background(fieldBackgroundView)
        .padding(.bottom, 40)
    }
    
}

#Preview {
    LoginView(
        viewModel: LoginViewModel(
            webRepository: AuthWebRepository(),
            rootEventTracker: RootEventTracker(),
            userWebRepository: UserWebRepository()
        )
    )
}
