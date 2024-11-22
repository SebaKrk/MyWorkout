//
//  Dependencies+ContainerExtension.swift
//  MyWorkout
//
//  Created by Sebastian Sciuba on 17/11/2024.
//

import Foundation
import Factory

/// `Container` extension for managing dependencies.
///
/// This extension defines dependency factories, serving as a central point
/// for managing instances in the application. It utilizes the [`Factory`](https://github.com/hmlongco/Factory) library,
/// which simplifies dependency injection and improves the scalability of the codebase.
///
/// Example:
/// ```swift
/// // Access the shared instance of AuthenticationService
/// let authenticationService = Container.shared.authenticationService()
/// authenticationService.login(username: "test", password: "password")
/// ```
extension Container {
    
    /// Factory providing a shared instance of `AuthenticationService`.
    ///
    /// `authenticationService` is a shared component delivered by the dependency container.
    /// By default, it returns an instance of `DefaultAuthenticationService`.
    ///
    /// - Properties:
    ///   - `.shared`: The factory uses a shared instance, meaning that
    ///     the same instance is reused throughout the application.
    ///
    /// - Returns: An object conforming to `AuthenticationService`.
    var authenticationService: Factory<AuthenticationService> {
        Factory(self) { DefaultAuthenticationService() }.shared
    }
    
    /// Factory providing a shared instance of `AnyUserProvider`.
    ///
    /// `userProvider` is a shared component delivered by the dependency container.
    /// By default, it returns an instance of `UserProvider`, which conforms to `AnyUserProvider`.
    ///
    var userProvider: Factory<AnyUserProvider> {
        Factory(self) { UserProvider() }.shared
    }
    
    ///
    var appStorage: Factory<AppStorageProtocol> {
        Factory(self) { DefaultAppStorage() }
    }
    
}

