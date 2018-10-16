//
//  SettingsWireframe.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 06/06/2017.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at Wireframe

protocol SettingsNavigationHandler: class {
    // Include methods to present or dismiss
}

// MARK: - Wireframe Class must implement RequestsHandler Protocol to handle Presenter Requests
class SettingsWireframe: SettingsNavigationHandler {
    weak var viewController: SettingsViewController?

}
