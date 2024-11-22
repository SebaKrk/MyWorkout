//
//  DefaultHealthStore.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 22/11/2024.
//

import HealthKit
import Foundation

final class DefaultHealthStore: HealthStore {
 
    // MARK: - Properties
    
    private let healthStore: HKHealthStore = HKHealthStore()
    
    private let bodyCompositionTypes: Set = [
        HKQuantityType(.bodyMass),           // Masa ciała
        HKQuantityType(.bodyMassIndex),     // Wskaźnik masy ciała (BMI)
        HKQuantityType(.leanBodyMass),      // Beztłuszczowa masa ciała
        HKQuantityType(.bodyFatPercentage)  // Procent tłuszczu w ciele
    ]
    
    private let activityAndHealthTypes: Set = [
        HKQuantityType.workoutType(),           // Treningi
        HKQuantityType(.activeEnergyBurned),    // Spalona energia aktywna
        HKQuantityType(.distanceWalkingRunning) // Dystans pieszo/biegiem
    ]

    // MARK: - API
    
    var isHealthDataAvailable: Bool {
        HKHealthStore.isHealthDataAvailable()
    }
    
    func requestAuthorizationForBodyCompositionTypes() async -> Result<Bool, Error> {
        do {
            try await healthStore.requestAuthorization(toShare: bodyCompositionTypes, read: bodyCompositionTypes)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func requestAuthorizationForActivityAndHealthTypes() async -> Result<Bool, Error> {
        do {
            try await healthStore.requestAuthorization(toShare: activityAndHealthTypes, read: activityAndHealthTypes)
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func checkAuthorizationStatus(for type: HKQuantityType) -> String {
        let status = healthStore.authorizationStatus(for: type)
        
        switch status {
        case .notDetermined:
            return "Authorization not determined for \(type.identifier)."
        case .sharingDenied:
            return "Authorization denied for \(type.identifier)."
        case .sharingAuthorized:
            return "Authorization granted for \(type.identifier)."
        @unknown default:
            return "Unknown authorization status for \(type.identifier)."
        }
    }
    
}



