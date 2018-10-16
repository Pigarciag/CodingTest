//
//  ItemListWireframe.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

// MARK: - Protocol to be defined at Wireframe
protocol ItemListNavigationHandler: class {
    // Include methods to present or dismiss
    func pushItemDetailView( _ itemID: POIIdentifier)
    func showNavigationDrawer(_ animated: Bool)
}

class ItemListWireframe {
    weak var viewController: ItemListViewController?

    public func pushItemDetailView( _ itemID: POIIdentifier) {
        let vc = ItemDetailBuilder.build(itemID)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    public func showNavigationDrawer(_ animated: Bool = true) {
        let vc = NavigationDrawerBuilder.build()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
