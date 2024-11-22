//
//  OnboardingView.swift
//  MyWorkout
//
//  Created by Sebastian Ściuba on 22/11/2024.
//

import Factory
import SwiftUI

struct OnboardingView: View {
    
    @Injected(\.appStorage) private var appStorage
    
    var body: some View {
        authorizeHealthKitButton
    }
    
    private var authorizeHealthKitButton: some View {
        Button {
            appStorage.completeOnboarding()
        } label: {
            Label("Authorize HealthKit Access", systemImage: "figure.run")
        }
    }
    
}
