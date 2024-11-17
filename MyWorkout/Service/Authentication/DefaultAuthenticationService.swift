//
//  DefaultAuthenticationService.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Factory
import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

final class DefaultAuthenticationService: AuthenticationService {
    
    // MARK: - Dependencies
    
    @LazyInjected(\.userProvider) private var userProvider
    
    // MARK: - Properties
    
    private let signIn: GIDSignIn
    private let auth: Auth
    
    // MARK: - Lifecycle
    
    init(signIn: GIDSignIn = .sharedInstance, auth: Auth = .auth()) {
        self.signIn = signIn
        self.auth = auth
        
        var configuration: GIDConfiguration
        var clientID: String
        
        let filePath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist")
        guard let prodClientID = FirebaseOptions(contentsOfFile: filePath!)?.clientID else {
            fatalError("Couldn't prod load config file")
        }
        
        clientID = prodClientID
        
        configuration = GIDConfiguration(clientID: clientID)
        signIn.configuration = configuration

    }
    
    // MARK: - API
    
    func signIn(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
        userProvider.sendLoginStateDidChangeEvent()
    }
    
    @MainActor
    func signInWithGoogle() async throws {
        do {
            if signIn.hasPreviousSignIn() {
                try await signIn.restorePreviousSignIn()
            } else {
                guard let rootViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
                    throw AuthenticationError.loginError
                }
                
                let result = try await signIn.signIn(withPresenting: rootViewController)
                try await authenticateUser(for: result, with: nil)

                var handler: AuthStateDidChangeListenerHandle?
                try await withCheckedThrowingContinuation { continuation in
                    handler = checkedThrowingContinuation(continuation: continuation)
                }
                
                userProvider.sendLoginStateDidChangeEvent()
                auth.removeStateDidChangeListener(handler!)
            }
        } catch let error as AuthenticationError {
            try await signOut()
            throw error
        } catch {
            try await signOut()
            throw AuthenticationError.loginError
        }
    }

    func signOut() async throws {
        try auth.signOut()
        userProvider.sendLoginStateDidChangeEvent()
    }
    
    // MARK: - Methods
    
    private func checkedThrowingContinuation(continuation: CheckedContinuation<(), Error>) -> AuthStateDidChangeListenerHandle? {
        let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            continuation.resume(throwing: NSError(domain: "User time out.", code: 0))
        }
        
        return auth.addStateDidChangeListener { auth, user in
            if user != nil {
                timer.invalidate()
                continuation.resume()
            }
        }
    }
    
    private func authenticateUser(for result: GIDSignInResult, with error: Error?) async throws {
        guard error == nil,
              let idToken = result.user.idToken?.tokenString else {
            throw AuthenticationError.loginError
        }
        
        let accessToken = result.user.accessToken.tokenString
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        try await auth.signIn(with: credential)
    }
    
}
