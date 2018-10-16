//
//  SettingsInteractor.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 06/06/2017.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Interactor

protocol SettingsRequestHandler: class {
    // func handle______Request()
    func requestOpenDrawerMenu()
}

// MARK: - Presenter Class must implement RequestHandler Protocol to handle Presenter Requests
class SettingsInteractor: SettingsRequestHandler {
    // MARK: VIPER relationships
    weak var presenter: SettingsResponseHandler?

    // MARK: RequestHandler Protocol Implementation

    //func handle_____Request() {}

    func requestOpenDrawerMenu() {
        SharedContainer().resolved(UseCaseNotifierProvider.self).notifier.notify { (obs: UseCaseNotifierProtocol) in
            obs.useCaseTriggered(UseCaseNotificationEntity.toggleDrawerMenu)
        }
    }
}
