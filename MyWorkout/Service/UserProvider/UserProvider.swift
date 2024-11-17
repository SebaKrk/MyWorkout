//
//  UserProvider.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Combine
import FirebaseAuth
import Foundation

public final class UserProvider: AnyUserProvider {
    
    // MARK: - Publisher
    
    lazy var loginStateDidChange = _loginStateDidChange.eraseToAnyPublisher()
    private lazy var _loginStateDidChange = PassthroughSubject<Void, Never>()
    
    // MARK: - Properties
    
    private let auth: Auth
    
    // MARK: - Lifecycle
    
    init(auth: Auth = .auth()) {
        self.auth = auth
    }
    
    // MARK: - API
    
    var isUserLoggedIn: Bool {
        auth.currentUser != nil
    }
    
    func getLoggedUserInfo() async throws -> LoggedUserInfo? {
        guard let currentUser = auth.currentUser else { return nil }
        let token = try await currentUser.getIDTokenResult(forcingRefresh: true)
        return LoggedUserInfo(id: currentUser.uid, token: token.token)
    }
    
    func sendLoginStateDidChangeEvent() {
        _loginStateDidChange.send()
    }
    
}
