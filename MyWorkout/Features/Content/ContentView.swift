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
    @State private var selection: AppScreen? = .activity
    
    // MARK: - View
    
    var body: some View {
        Group {
            if let isUserLoggedIn = viewModel.isUserLoggedIn {
                if isUserLoggedIn {
                    AppTabView(selection: $selection)
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
