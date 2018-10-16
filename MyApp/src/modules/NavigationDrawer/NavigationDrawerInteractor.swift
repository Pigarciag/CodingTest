//
//  NavigationDrawerInteractor.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

class NavigationDrawerInteractor: UseCaseNotifierProtocol {
    weak var presenter: NavigationDrawerResponseHandler?

    init() {
        SharedContainer().resolved(UseCaseNotifierProvider.self).notifier.addObserver(observer: self)
    }

    // MARK: UseCaseNotifierProtocol
    func useCaseTriggered(_ useCase: UseCaseNotificationEntity) {
        switch useCase {
        case .toggleDrawerMenu:
            presenter?.toggleDrawerMenu()
        case let .drawerMenuItemPressed(item):
            presenter?.drawerMenuItemPressed(item)
        }
    }
}
