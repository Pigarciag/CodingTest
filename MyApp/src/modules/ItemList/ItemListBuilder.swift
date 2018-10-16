//
//  ItemListBuilder.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

class ItemListBuilder {
    static func build() -> UIViewController {
        let viewController = ItemListViewController(nibName: String.init(describing: ItemListViewController.self), bundle: nil)
        let presenter = ItemListPresenter()
        let interactor = ItemListInteractor()
        let wireframe = ItemListWireframe()

        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
        presenter.wireframe = wireframe
        interactor.presenter = presenter
        wireframe.viewController = viewController

        _ = viewController.view //force loading the view to load the outlets
        presenter.dataSource.tableView = viewController.tableView
        return viewController
    }
}
