//
//  DrawerMenuBuilder.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

class DrawerMenuBuilder: NSObject {

    static func createDrawerMenuModule() -> DrawerMenuVC {

        let viewController = DrawerMenuVC(nibName: "DrawerMenuVC", bundle: nil)
        let presenter = DrawerMenuPresenter()
        let interactor = DrawerMenuInteractor()
        let wireframe = DrawerMenuWireframe()

        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter

        _ = viewController.view
        presenter.dataSource.tableView = viewController.tableView

        return viewController
    }

}
