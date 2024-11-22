//
//  ContentViewModel.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Combine
import Factory
import Foundation

@MainActor
final class ContentViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    @LazyInjected(\.userProvider) private var userProvider
    
    // MARK: - Propeties
    
    private var cancellables = [AnyCancellable]()
    
    // MARK: - Properties
    
    @Published var isUserLoggedIn: Bool?
    
    // MARK: - API
    
    func start() {
        isUserLoggedIn = userProvider.isUserLoggedIn
        bind()
    }
    
    // MARK: - Methods
    
    private func bind() {
        userProvider.loginStateDidChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                isUserLoggedIn = userProvider.isUserLoggedIn
            }
            .store(in: &cancellables)
    }
    
}
