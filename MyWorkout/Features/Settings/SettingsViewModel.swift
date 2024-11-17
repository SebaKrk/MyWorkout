//
//  SettingsViewModel.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Factory
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    @LazyInjected(\.authenticationService) private var authenticationService
    
    // MARK: - API
    
    func signOut() async {
        do {
            try await authenticationService.signOut()
        } catch {
            print("LOGOUT ERROR:",  error.localizedDescription)
        }
    }
    
}
