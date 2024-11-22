//
//  DefaultAppStorage.swift
//  MyWorkout
//
//  Created by Sebastian Ściuba on 22/11/2024.
//

import SwiftUI

final class DefaultAppStorage: AppStorageProtocol {
    
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboardingStorage: Bool = false
    
    var hasCompletedOnboarding: Bool {
        get { hasCompletedOnboardingStorage }
        set { hasCompletedOnboardingStorage = newValue }
    }
    
    func completeOnboarding() {
         hasCompletedOnboarding = true
     }
    
    func resetOnboarding() {
        hasCompletedOnboarding = false
    }

}
