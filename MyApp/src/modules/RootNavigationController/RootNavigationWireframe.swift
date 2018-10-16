//
//  RootNavigationWireframe.swift
//  MyApp
//
//  Created by Jonattan Nieto Sánchez on 15/5/17.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import UIKit

// MARK: - Protocol to be defined at Wireframe
protocol RootNavigationNavigationHandler: class {
    // Include methods to present or dismiss
    func showItemListView(_ animated: Bool)
    func showNavigationDrawer(_ animated: Bool)
}

// MARK: - Wireframe Class must implement RequestsHandler Protocol to handle Presenter Requests
class RootNavigationWireframe: RootNavigationNavigationHandler {

    weak var viewController: RootNavigationViewController?

    public func showItemListView(_ animated: Bool = true) {
        let vc = ItemListBuilder.build()
        viewController?.setViewControllers([vc], animated: animated)
    }

    public func showNavigationDrawer(_ animated: Bool = true) {
        let vc = NavigationDrawerBuilder.build()
        viewController?.setViewControllers([vc], animated: animated)
    }
}
