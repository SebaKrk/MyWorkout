//
//  SettingsView.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: SettingsViewModel
    
    // MARK: - View
    
    var body: some View {
        VStack {
            signOutButton
            Spacer()
        }
        .padding()
        .background(Color(uiColor: .secondarySystemBackground))
    }
    
    // MARK: - Subviews
    
    @ViewBuilder
    private var signOutButton: some View {
        Button {
            Task {
                await viewModel.signOut()
            }
        } label: {
            Text("WYLOGUJ")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding(.horizontal)
    }
    
}
