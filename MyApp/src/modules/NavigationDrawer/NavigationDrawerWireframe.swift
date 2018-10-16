//
//  NavigationDrawerWireframe.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

class NavigationDrawerWireframe: NSObject {

    weak private(set) var navigationDrawerController: NavigationDrawerViewController?

    private var navigationController: UINavigationController? {
        return navigationDrawerController?.rootViewController as? UINavigationController
    }

    init(_ navigationDrawerViewController: NavigationDrawerViewController) {
        self.navigationDrawerController = navigationDrawerViewController
    }

    public func showViewForMenuItem( _ item: MenuItemType) {
        switch item {
        case .POIs:
            showItemListView()
        case .settings:
            showSettingsView()
        }
    }

    public func showItemListView(_ animated: Bool = true) {
        let vc = ItemListBuilder.build()
        self.navigationController?.setViewControllers([vc], animated: animated)
    }

    public func showSettingsView(_ animated: Bool = true) {
        let vc = SettingsBuilder.build()
        self.navigationController?.setViewControllers([vc], animated: animated)
    }

    public func showDrawerMenu() {
        self.navigationDrawerController?.openLeftView()
    }

    public func hideDrawerMenu() {
        self.navigationDrawerController?.closeLeftView()
    }

    public func toggleDrawerMenu() {
        if let vc = self.navigationDrawerController {
            if vc.isLeftViewOpened {
                hideDrawerMenu()
            } else {
                showDrawerMenu()
            }
        }
    }
}
