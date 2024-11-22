//
//  OnboardingView.swift
//  MyWorkout
//
//  Created by Sebastian Ściuba on 22/11/2024.
//

import Factory
import SwiftUI
import HealthKit

struct OnboardingView: View {
    
    @Injected(\.appStorage) private var appStorage
    @Injected(\.healthStore) private var healthStore
    
    @State private var showAlert = false
    
    var body: some View {
        authorizeHealthKitButton
    }
    
    private var authorizeHealthKitButton: some View {
        VStack {
            Button {
                if healthStore.isHealthDataAvailable {
                    Task {
                        let result = await healthStore.requestAuthorizationForBodyCompositionTypes()
                        switch result {
                        case .success:
                            appStorage.completeOnboarding()
                        case .failure(let error):
                            print("Authorization failed with error: \(error.localizedDescription)")
                            
                        }
                    }
                } else {
                    showAlert.toggle()
                }
            } label: {
                if healthStore.isHealthDataAvailable {
                    Label("Authorize HealthKit Access -  Body Composition Types", systemImage: "figure.run")
                } else {
                    Text("Health Data Available")
                }
            }
        }
        .alert("Information", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Your device cannot fetch data from HealthKit. Please ensure HealthKit is enabled and try again.")
        }
        
    }
    
}
