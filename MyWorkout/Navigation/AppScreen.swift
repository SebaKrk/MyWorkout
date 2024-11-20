//
//  AppScreen.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 20/11/2024.
//

import SwiftUI

enum AppScreen: Codable, Hashable, Identifiable, CaseIterable {
    
    case activity
    case cardio
    case nutrition
    case weight
    case settings
    
    var id: AppScreen { self }
    
}

@MainActor
extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .activity:
            Label(
                String(localized: "Activity", comment: "The Activity Tab displays physical activity data such as steps and calories burned."),
                systemImage: "figure.run"
            )
        case .cardio:
            Label(
                String(localized: "Cardio", comment: "The Cardio Tab displays heart rate data and trends over time."),
                systemImage: "waveform.path.ecg"
            )
        case .nutrition:
            Label(
                String(localized: "Nutrition", comment: "The Nutrition Tab tracks calorie intake, macronutrients, and water consumption."),
                systemImage: "fork.knife"
            )
        case .weight:
            Label(
                String(localized: "Weight", comment: "The Weight Tab monitors body weight and calculates BMI."),
                systemImage: "gauge.with.needle.fill"
            )
        case .settings:
            Label(
                String(localized: "Settings", comment: "The Settings Tab provides options to manage permissions and goals."),
                systemImage: "gearshape"
            )
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .activity:
            Text("activity")
        case .cardio:
            Text("cardio")
        case .nutrition:
            Text("nutrition")
        case .weight:
            Text("weight")
        case .settings:
            SettingsView(viewModel: SettingsViewModel())
        }
    }
    
}
