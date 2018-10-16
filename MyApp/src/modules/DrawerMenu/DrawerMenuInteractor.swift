//
//  DrawerMenuInteractor.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

protocol DrawerMenuRequestHandler: class {
    func requestMenuItems() -> [MenuItemEntity]
    func requestSendMenuItemPressed( _ item: MenuItemType)
}

class DrawerMenuInteractor: DrawerMenuRequestHandler {
    weak var presenter: DrawerMenuPresenter!

    func requestMenuItems() -> [MenuItemEntity] {
        return [MenuItemEntity(identifier: MenuItemType.POIs.rawValue, title: "POIs"),
                MenuItemEntity(identifier: MenuItemType.settings.rawValue, title: "Settings")]
    }

    func requestSendMenuItemPressed( _ item: MenuItemType) {
        SharedContainer().resolved(UseCaseNotifierProvider.self).notifier.notify { (observer) in
            observer.useCaseTriggered(UseCaseNotificationEntity.drawerMenuItemPressed(item: item))
        }
    }
}
