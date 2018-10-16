//
//  NavigationDrawerBuilder.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

class NavigationDrawerBuilder: NSObject {
    static func build() -> NavigationDrawerViewController {

        let navigationController = UINavigationController(rootViewController: ItemListBuilder.build())
        let drawerMenu = DrawerMenuBuilder.createDrawerMenuModule()

        let vc = NavigationDrawerViewController(rootViewController: navigationController,
                                                leftViewController: drawerMenu,
                                                rightViewController: nil)
        let presenter = NavigationDrawerPresenter()
        let interactor = NavigationDrawerInteractor()
        let wireframe = NavigationDrawerWireframe(vc)

        vc.presenter = presenter
        presenter.view = vc
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter

        return vc
    }
}
