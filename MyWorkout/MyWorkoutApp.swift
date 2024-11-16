//
//  MyWorkoutApp.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 16/11/2024.
//

import SwiftUI

@main
struct MyWorkoutApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Lifecycle
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
    
    // MARK: - View
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
