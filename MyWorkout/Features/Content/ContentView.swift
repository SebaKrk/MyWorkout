//
//  ContentView.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 16/11/2024.
//

import Factory
import SwiftUI

struct ContentView: View {
    
    @LazyInjected(\.authenticationService) private var authenticationService
    
    // MARK: - Properties
    
    @ObservedObject var viewModel = ContentViewModel()
    
    // MARK: - View
    
    var body: some View {
        Group {
            if let isUserLoggedIn = viewModel.isUserLoggedIn {
                if isUserLoggedIn {
                    if viewModel.isOnboardingCompleted {
                        OnboardingView()
                    } else {
                        SettingsView(viewModel: SettingsViewModel())
                    }
                } else {
                    LoginView()
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.start()
        }
    }
    
}
