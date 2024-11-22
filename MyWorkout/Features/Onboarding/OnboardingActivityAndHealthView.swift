//
//  OnboardingActivityAndHealthView.swift
//  MyWorkout
//
//  Created by Sebastian Ściuba on 22/11/2024.
//

import Factory
import SwiftUI

struct OnboardingActivityAndHealthView: View {
    
    @Injected(\.healthStore) private var healthStore
    
    @Binding var canProceedToNextStep: Bool
    
    var body: some View {
        VStack {
            Spacer()
            authorizeHealthKitButton
            Spacer()
        }
    }
    
    private var authorizeHealthKitButton: some View {
        VStack {
            Button {
                if healthStore.isHealthDataAvailable {
                    Task {
                        let result = await healthStore.requestAuthorizationForActivityAndHealthTypes()
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
                        Text("Activity and Health Types")
                    }
                } else {
                    Text("Health Data no Available")
                }
            }
        }

    }
}
