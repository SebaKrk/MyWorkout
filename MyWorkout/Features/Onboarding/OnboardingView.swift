//
//  OnboardingView.swift
//  MyWorkout
//
//  Created by Sebastian Ściuba on 22/11/2024.
//

import Factory
import SwiftUI
import HealthKit

struct OnboardingView: View {
    
    @Injected(\.appStorage) private var appStorage
    @Injected(\.healthStore) private var healthStore
    
    @State private var showAlert = false
    @State private var onboardingState: OnboardingState = .welcome
    @State private var canProceedToNextStep: Bool = true
    
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading))
    
    var body: some View {
        ZStack {
            ZStack {
                switch onboardingState {
                case .welcome:
                    welcomeView
                        .transition(transition)
                case .bodyComposition:
                    OnboardingBodyMassView(canProceedToNextStep: $canProceedToNextStep)
                        .transition(transition)
                case .activityAndHealth:
                    OnboardingActivityAndHealthView(canProceedToNextStep: $canProceedToNextStep)
                        .transition(transition)
                case .end:
                    Text("End")
                        .transition(transition)
                        .onAppear() {
                            appStorage.completeOnboarding()
                        }
                }
            }
            VStack {
                Spacer()
                if canProceedToNextStep {
                    nextButton
                }
            }
        }
    }
    
    private var welcomeView: some View {
        Text("Welcome to the HealthKit Demo")
            .font(.title)
            .padding()
    }
    
    private var nextButton: some View {
        Button {
            handleNextButton()
        } label: {
            if onboardingState.rawValue == 3 {
                Label("Finish", systemImage: "arrow.right")
            } else  {
                Label("Next", systemImage: "arrow.right")
            }
            
        }
        
    }
    
    private func handleNextButton() {
        withAnimation {
            if let nextState = onboardingState.next {
                onboardingState = nextState
                canProceedToNextStep = false 
            }
        }
    }
        
}
