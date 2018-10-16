//
//  RootNavigationBuilder.swift
//  MyApp
//
//  Created by Jonattan Nieto Sánchez on 15/5/17.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation
import UIKit

class RootNavigationBuilder {
    static func build() -> UIViewController {
        let viewController = RootNavigationViewController()
        let presenter = RootNavigationPresenter()
        let interactor = RootNavigationInteractor()
        let wireframe = RootNavigationWireframe()

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
