//
//  AppStorageProtocol.swift
//  MyWorkout
//
//  Created by Sebastian Ściuba on 22/11/2024.
//

import Foundation

/// A protocol that defines the interface for managing persistent application storage.
///
/// `AppStorageProtocol` provides a way to manage key application states, such as the completion
/// of the onboarding process. This protocol abstracts the underlying storage mechanism, allowing
/// for easier testing and flexibility in implementation.
///
protocol AppStorageProtocol {
    
    /// A Boolean value indicating whether the onboarding process has been completed.
    ///
    /// - `true`: The user has completed the onboarding process.
    /// - `false`: The user has not completed the onboarding process.
    var hasCompletedOnboarding: Bool { get set }
    
    /// Marks the onboarding process as completed.
    ///
    /// This method sets the `hasCompletedOnboarding` property to `true` and persists
    /// the change to the underlying storage.
    func completeOnboarding()
    
    /// Resets the onboarding completion state.
    ///
    /// This method sets the `hasCompletedOnboarding` property to `false`, effectively
    /// resetting the onboarding state for the application.
    func resetOnboarding()
    
}
