//
//  LoginViewModel.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Factory
import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    @LazyInjected(\.authenticationService) private var authenticationService
    
    // MARK: - Properties
    
    @Published var emailValue = "test@gmail.com"
    @Published var passwordValue = "test1234"
    @Published var isLoginProcessUnderway = false
    
    // MARK: - API
    
    func signInWithEmailAndPassword() async {
        do {
            isLoginProcessUnderway = true
            try await authenticationService.signIn(email: emailValue, password: passwordValue)
        } catch {
            print("LOGIN ERROR:", error.localizedDescription )
        }
    }
    
    func signInWithGoogle() async {
        do {
            try await authenticationService.signInWithGoogle()
        } catch {
            print("LOGIN ERROR:", error.localizedDescription )
        }
    }
    
    func signInWithGitHub() async {
        do {
            try await authenticationService.signInWithGitHub()
        } catch {
            print("LOGIN ERROR:", error.localizedDescription )
        }
    }

}
