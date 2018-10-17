//
//  ItemListVC.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import CoreData

import T21PullToRefreshController
import MBProgressHUD

// MARK: - Protocol to be defined at ViewController
protocol ItemListViewModelHandler: class {
    //That part should be implemented with RxSwift.
    func animatePullToRefreshLoading(show: Bool)
    func showErrorFeedback( _ message: String)

}

class ItemListViewController: UIViewController, NavigationBarDrawerMenuButtonItemProtocol, ItemListViewModelHandler {

    var presenter: ItemListEventHandler!

    @IBOutlet weak var searchBar: UISearchBar?

    @IBOutlet
    weak var tableView: UITableView?

    var viewModel: ItemListViewModel {
        return presenter.viewModel
    }

    override func viewDidLoad() {
        Logger.info("Load Item List View")
        super.viewDidLoad()
        searchBar?.delegate = self

        _ = self.tableView?.addPullToRefresh(refreshBlock: { () in
            self.presenter.itemListPullToRefreshReceived()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        print("ViewController: ViewWillAppear")
        super.viewWillAppear(animated)
        presenter.itemListViewWillAppear()
        self.navigationItem.leftBarButtonItem = NavigationBarItemsFactory.createDrawerMenuButtonItem(self)
    }

    // MARK: Interface
    func animatePullToRefreshLoading(show: Bool) {
        if show {
            self.tableView?.startPullToRefreshAnimation()
        } else {
            self.tableView?.finishPullToRefreshAnimation()
        }
    }

    func showErrorFeedback( _ message: String) {
        let loadingHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        loadingHUD.mode = MBProgressHUDMode.text
        loadingHUD.label.text = message
        loadingHUD.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        loadingHUD.removeFromSuperViewOnHide = true
        loadingHUD.isUserInteractionEnabled = false
        loadingHUD.hide(animated: true, afterDelay: 3)
    }

    // MARK: NavigationBarDrawerMenuButtonItemProtocol
    func navigationBarDrawerMenuButtonPressed() {
        presenter?.itemListViewDidPressMenuButton()
    }

}

// Search Bar Delegate
extension ItemListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let txt = searchBar.text else {
            return
        }
        presenter.refresh(txt)
        searchBar.resignFirstResponder()
        self.tableView?.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        presenter.reloadData()
        self.tableView?.reloadData()
    }
}
