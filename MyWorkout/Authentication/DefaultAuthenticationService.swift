//
//  DefaultAuthenticationService.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Foundation
import FirebaseAuth

final class DefaultAuthenticationService: AuthenticationService {
    
    // MARK: - Properties
    
    private let auth: Auth
    
    // MARK: - Lifecycle
    
    init(auth: Auth =  .auth()) {
        self.auth = auth
    }
    
    // MARK: - API
    
    func signIn(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func signOut() async throws {
        try auth.signOut()
    }
    
}
