//
//  NavigationDrawerPresenter.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

protocol NavigationDrawerResponseHandler: class {
    func toggleDrawerMenu()
    func showDrawerMenu()
    func hideDrawerMenu()
    func drawerMenuItemPressed( _ item: MenuItemType)
}

class NavigationDrawerPresenter: NavigationDrawerResponseHandler {

    weak var view: NavigationDrawerViewController?
    var interactor: NavigationDrawerInteractor!
    var wireframe: NavigationDrawerWireframe!

    // MARK: NavigationDrawerInteractorHandler
    func toggleDrawerMenu() {
        wireframe.toggleDrawerMenu()
    }

    func drawerMenuItemPressed( _ item: MenuItemType) {
        wireframe.showViewForMenuItem(item)
        wireframe.hideDrawerMenu()
    }

    func showDrawerMenu() {
        wireframe.showDrawerMenu()
    }

    func hideDrawerMenu() {
        wireframe.hideDrawerMenu()
    }
}
