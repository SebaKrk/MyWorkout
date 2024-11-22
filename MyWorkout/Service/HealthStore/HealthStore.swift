//
//  HealthStore.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 22/11/2024.
//

import Foundation
import HealthKit

protocol HealthStore {
    
    var isHealthDataAvailable: Bool { get }
    func requestAuthorizationForBodyCompositionTypes() async -> Result<Bool, Error>
    func requestAuthorizationForActivityAndHealthTypes() async -> Result<Bool, Error>
    func checkAuthorizationStatus(for type: HKQuantityType) -> String
    
}
