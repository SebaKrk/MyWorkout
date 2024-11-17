//
//  ContentView.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 16/11/2024.
//

import Factory
import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel = ContentViewModel()
    
    // MARK: - View
    
    var body: some View {
        Group {
            if let isUserLoggedIn = viewModel.isUserLoggedIn {
                if isUserLoggedIn {
                    Text("zalogowany")
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
