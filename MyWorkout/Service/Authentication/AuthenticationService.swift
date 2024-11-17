//
//  AuthenticationService.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Foundation

protocol AuthenticationService {
    
    /// Method to authenticate the user with `Google`.
    func signInWithGoogle() async throws

    /// Method to authenticate the user with `email` and `password`.
    func signIn(email: String, password: String) async throws
    
    /// Method for log out the user.
    func signOut() async throws
    
}
