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
    
    @Published var emailValue = "admin@gmail.com"
    @Published var passwordValue = "admin1234"
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
}
