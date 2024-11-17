//
//  AnyUserProvider.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//


import Combine
import Foundation

protocol AnyUserProvider {
    
    var loginStateDidChange: AnyPublisher<Void, Never> { get set }
    var isUserLoggedIn: Bool { get }
    
    func sendLoginStateDidChangeEvent()
    
    /// Responsible for getting logged user info, and refresh token if needed.
    func getLoggedUserInfo() async throws -> LoggedUserInfo?
    
}
