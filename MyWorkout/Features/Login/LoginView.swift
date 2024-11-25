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
            googleButton
            gitHubButton
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
            Task { await viewModel.signInWithEmailAndPassword() }
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
                Spacer().frame(width: 20)
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
    private var gitHubButton: some View {
        Button {
            Task { await viewModel.signInWithGitHub() }
        } label: {
            HStack {
                if let gitHunImage = UIImage(named: "avatar-placeholder") {
                    Image(uiImage: gitHunImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                }
                Spacer().frame(width: 20)
                Text("Sign in with GitHub")
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
    private var googleButton: some View {
        Button {
            Task { await viewModel.signInWithGoogle() }
        } label: {
            HStack {
                if let googleImage = UIImage(named: "GoogleSignIn") {
                    Image(uiImage: googleImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    Spacer().frame(width: 20)
                    Text("Sign in with Google")
                        .foregroundColor(.black)
                }
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
