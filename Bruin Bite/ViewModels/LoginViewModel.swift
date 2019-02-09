//
//  LoginViewModel.swift
//  Bruin Bite
//
//  Created by Samuel J. Lee on 10/4/18.
//  Copyright © 2018 Dont Eat Alone. All rights reserved.
//

import Foundation

class LoginViewModel: ServiceAccessible {

    private (set) var dependencyContainer: DependencyContainerProtocol
    private (set) var launchOptions: [AnyHashable: Any]?

    var shouldGoToMenu: (() -> Void)?
    var shouldGoToSignIn: (() -> Void)?
    var shouldGoToSignUp: (() -> Void)?
    var shouldCreateProfile: (() -> Void)?

    init(dependencyContainer: DependencyContainerProtocol, launchOptions: [AnyHashable: Any]?) {
        self.dependencyContainer = dependencyContainer
        self.launchOptions = launchOptions
    }
}
