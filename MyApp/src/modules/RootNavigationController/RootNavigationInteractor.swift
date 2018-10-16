//
//  RootNavigationInteractor.swift
//  MyApp
//
//  Created by Jonattan Nieto Sánchez on 15/5/17.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Interactor
protocol RootNavigationRequestHandler: class {
    // func handle______Request()
}

// MARK: - Presenter Class must implement RequestHandler Protocol to handle Presenter Requests
class RootNavigationInteractor: RootNavigationRequestHandler {
    // MARK: VIPER relationships
    weak var presenter: RootNavigationResponseHandler?

    // MARK: RequestHandler Protocol Implementation

}
