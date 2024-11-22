//
//  OnboardingBodyMassView.swift
//  MyWorkout
//
//  Created by Sebastian Ściuba on 22/11/2024.
//

import Factory
import SwiftUI

struct OnboardingBodyMassView: View {
    
    @Injected(\.healthStore) private var healthStore
    
    @Binding var canProceedToNextStep: Bool
    
    var body: some View {
        VStack {
            Spacer()
            authorizationBodyMassButton
            Spacer()
        }
    }
    
    private var authorizationBodyMassButton: some View {
        VStack {
            Button {
                if healthStore.isHealthDataAvailable {
                    Task {
                        let result = await healthStore.requestAuthorizationForBodyCompositionTypes()
                        switch result {
                        case .success:
                            canProceedToNextStep = true
                        case .failure(let error):
                            print("Authorization failed with error: \(error.localizedDescription)")
                            
                        }
                    }
                }
            } label: {
                if healthStore.isHealthDataAvailable {
                    VStack {
                        Text("Authorize HealthKit Access")
                        Label("Body Composition Types", systemImage: "figure.run")
                    }
                } else {
                    Text("Health Data no Available")
                }
            }
        }
    }
    
}
