//
//  DrawerMenuPresenter.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import T21TableViewDataSource
import T21RxAdditions

class DrawerMenuPresenter: DrawerMenuEventHandler {
    weak var view: DrawerMenuVC!
    var interactor: DrawerMenuRequestHandler!
    var wireframe: DrawerMenuWireframe!

    var dataSource = TableViewDataSource<DrawerMenuCellViewModel>()
    var viewModel: DrawerMenuViewModel = DrawerMenuViewModel()

    init() {

        dataSource.onTableViewDidSetFunction = { (tableView) in
            tableView?.register(UINib.init(nibName: "DrawerMenuCell", bundle: nil), forCellReuseIdentifier: "cell")
        }

        dataSource.cellForRowFunction = {(tableView, indexPath, item) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DrawerMenuCell else {
                return UITableViewCell()
            }
            cell.viewModel = item
            return cell
        }

        dataSource.didSelectRowFunction = { [weak self] (tableView, indexPath, item) in
            let type = MenuItemType(rawValue: item.identifier)!
            self?.interactor.requestSendMenuItemPressed(type)
        }

        bindOnNext(viewModel.items) { [weak self] (items) -> Void in
            self?.dataSource.addItems(items)
        }
    }

    func viewWillAppear( _ animated: Bool) {
        viewModel.items.value = interactor.requestMenuItems().enumerated().map { (index, element) -> DrawerMenuCellViewModel in
            return DrawerMenuCellViewModel(element.identifier, element.title, index)
        }
    }
}
