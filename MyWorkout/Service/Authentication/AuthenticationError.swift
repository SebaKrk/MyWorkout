//
//  AuthenticationError.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Foundation

/// Errors dedicated for authentication exceptions.
public enum AuthenticationError: LocalizedError {
    
    /// Error occurring when login operation fail
    case loginError
    
    /// Error occurring when logout operation fail
    case logoutError
    
    /// Error occurring when user lost his internet connection
    case internetConnectionLost
    
    // MARK: - Properties
    
    public var errorDescription: String? {
        switch self {
        case .loginError:
            return NSLocalizedString("Coś poszło nie tak. Spróbuj ponownie.",
                                     comment: "Błąd logowania")
        case .logoutError:
            return NSLocalizedString("Wylogowanie nie powiodło się.",
                                     comment: "Błąd pobierania danych")
        
        case .internetConnectionLost:
            return NSLocalizedString("Brak połączenia z internetem. Spróbuj ponownie później.",
                                     comment: "Brak połączenia z internetem")
        }
    }
    
}
