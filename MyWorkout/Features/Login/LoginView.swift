//
//  LoginView.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import SwiftUI

struct LoginView: View {

    // MARK: - Properties
    
    @ObservedObject var viewModel = LoginViewModel()
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            emailTextField
            passwordTextField
            continueButton
            separator
            appleButton
            Spacer()
        }
        .padding()
        .overlay {
            if viewModel.isLoginProcessUnderway {
                progressView
            }
        }
    }
    
    // MARK: - Subview
    
    @ViewBuilder
    private var emailTextField: some View {
        TextField("Email", text: $viewModel.emailValue)
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private var passwordTextField: some View {
        SecureField("Hasło", text: $viewModel.passwordValue)
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
    
    @ViewBuilder
    private var separator: some View {
        HStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
            Text("or use")
                .foregroundColor(.gray)
                .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
        }
        .padding(.horizontal)
    }
    
    
    @ViewBuilder
    private var continueButton: some View {
        Button {
            Task {
                await viewModel.signInWithEmailAndPassword()
            }
        } label: {
            Text("continue".uppercased())
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder
    private var appleButton: some View {
        Button {
            
        } label: {
            HStack {
                Image(systemName: "apple.logo")
                    .foregroundColor(.black)
                Text("Sign in with Apple")
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
        .padding(.horizontal)
        .disabled(viewModel.isLoginProcessUnderway)
    }
    
    @ViewBuilder
    private var progressView: some View {
        GeometryReader { geo in
            ProgressView()
                .tint(.blue)
                .frame(width: geo.size.width, height: geo.size.height)
                .background(.gray.opacity(0.3))
        }
    }
    
}
