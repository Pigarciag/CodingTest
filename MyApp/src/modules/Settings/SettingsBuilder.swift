//
//  SettingsBuilder.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 06/06/2017.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation
import UIKit

class SettingsBuilder {
    static func build() -> UIViewController {
        let viewController = SettingsViewController(nibName: String.init(describing: SettingsViewController.self), bundle: nil)
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor()
        let wireframe = SettingsWireframe()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = viewController

        _ = viewController.view //force loading the view to load the outlets
        return viewController
    }
}
