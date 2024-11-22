//
//  OnboardingState.swift
//  MyWorkout
//
//  Created by Sebastian Ściuba on 22/11/2024.
//

import Foundation

enum OnboardingState: Int, CaseIterable {
    
    case welcome = 0
    case bodyComposition = 1
    case activityAndHealth = 2
    case end = 3
    
    var next: OnboardingState? {
        let nextIndex = self.rawValue + 1
        return OnboardingState(rawValue: nextIndex)
    }
    
    var back: OnboardingState? {
        let nextIndex = self.rawValue - 1
        return OnboardingState(rawValue: nextIndex)
    }
    
}
