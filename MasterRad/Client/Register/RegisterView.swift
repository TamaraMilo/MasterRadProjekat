//
//  RegisterView.swift
//  MasterRad
//
//  Created by Tamara Milovanovic on 24.9.24..
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var viewModel: RegisterViewModel
    @State private var startAnimation: Bool = false
    @State private var isPasswordShowing: Bool = false
    @State private var isRepeatPasswordShowing: Bool = false

    var body: some View {
        rootView
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Error logging"),
                    message: Text(viewModel.alertText),
                    dismissButton: .default(Text("Cancel"))
                )
            }
    }
}

extension RegisterView {
    var rootView: some View {
        VStack(alignment: .center, spacing: 18) {
            crossGymIconView
            emailTextFieldView
            passwordView
            repeatPasswordView
            nameTextFieldView
            surnameTextFieldView
            ageTextFieldView
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
            .frame(width: 170, height: 170)
            .padding(.top, 80)
    }
    
    var emailTextFieldView: some View {
        TextField("Email", text: $viewModel.email)
            .keyboardType(.emailAddress)
            .foregroundStyle(.black)
            .padding()
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
    
    @ViewBuilder
    var repeatPasswordView: some View {
        if isRepeatPasswordShowing {
            repeatPasswordTextFieldView
        } else {
            hiddenRepeatPasswordView
        }
    }
    
    var repeatPasswordTextFieldView: some View {
        HStack {
            TextField("Repeat password", text: $viewModel.repeatedPassword)
                .padding()
                .foregroundStyle(.black)
                .background(fieldBackgroundView)
            
            Spacer()
            
            Image(systemName: "eye.slash.fill")
                .onTapGesture {
                    isRepeatPasswordShowing = false
                }
        }
    }
    
    var hiddenRepeatPasswordView: some View {
        HStack {
            SecureField("Repeat password", text: $viewModel.repeatedPassword)
                .padding()
                .foregroundStyle(.black)
                .background(fieldBackgroundView)
        
            Spacer()
            
            Image(systemName: "eye.fill")
                .onTapGesture {
                    isRepeatPasswordShowing = true
                }
        }
    }
    
    var nameTextFieldView: some View {
        TextField("Name", text: $viewModel.name)
            .padding()
            .foregroundStyle(.black)
            .background(fieldBackgroundView)
    }
    
    var surnameTextFieldView: some View {
        TextField("Surname", text: $viewModel.surname)
            .padding()
            .foregroundStyle(.black)
            .background(fieldBackgroundView)
    }
    
    var ageTextFieldView: some View {
        TextField("Age", text: $viewModel.age)
            .keyboardType(.numberPad)
            .padding()
            .foregroundStyle(.black)
            .background(fieldBackgroundView)
    }
    
    var singUpTextView: some View {
        Text("Already have account? Sign in!")
            .foregroundColor(.black)
            .onTapGesture(perform: viewModel.openLoginView)
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
        Button(action: viewModel.signUp) {
            HStack {
                Spacer()
                Text("Sign up")
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
    RegisterView(viewModel: RegisterViewModel(
        authWebRepository: AuthWebRepository(),
        userWebRepository: UserWebRepository(),
        rootEventTracker: RootEventTracker()
        )
    )
}
