//
//  SettingsPresenter.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 06/06/2017.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Presenter
protocol SettingsEventHandler: class {
    var viewModel: SettingsViewModel { get }
    func handleViewWillAppearEvent()
    func handleViewWillDisappearEvent()
}

// MARK: - Protocol to be defined at Presenter
protocol SettingsResponseHandler: class {
    // func handle______Response()
}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses

class SettingsPresenter: SettingsEventHandler, SettingsResponseHandler, NavigationBarDrawerMenuButtonItemProtocol {

    // MARK: relationships
    weak var viewController: SettingsViewModelHandler?
    var interactor: SettingsRequestHandler!
    var wireframe: SettingsNavigationHandler!
    let viewModel = SettingsViewModel()

    // MARK: EventHandler Protocol Implementation
    func handleViewWillAppearEvent() {

    }

    func handleViewWillDisappearEvent() {

    }

    func navigationBarDrawerMenuButtonPressed() {
        interactor.requestOpenDrawerMenu()
    }

    // MARK: ResponseHandler Protocol Implementation

    //func handle_____Response() {}

}
