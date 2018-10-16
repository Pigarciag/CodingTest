//
//  ItemDetailBuilder.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 21/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

class ItemDetailBuilder {
    static func build( _ itemId: POIIdentifier) -> ItemDetailViewController {
        let viewController = ItemDetailViewController(nibName: String(describing: "ItemDetailViewController".self), bundle: nil)
        let presenter = ItemDetailPresenter()
        let interactor = ItemDetailInteractor(itemId)
        let wireframe = ItemDetailWireframe()

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
