//
//  ItemListPresenter.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import CoreData
import T21TableViewDataSource //pod 'T21TableViewDataSource'

// MARK: - Protocol to be defined at Presenter
protocol ItemListEventHandler: class {
    var viewModel: ItemListViewModel { get set }
    func itemListViewWillAppear()
    func itemListViewDidPressMenuButton()
    func itemListPullToRefreshReceived()
    func search(_ txt: String)
    func reloadData()
}

// MARK: - Protocol to be defined at Presenter
protocol ItemListResponseHandler: class {
    // func handle______Response()
    func requestGetPOIsDidStart()
    func requestGetPOIsDidFinish( _ result: GetPOIsEntity)

}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses

class ItemListPresenter: ItemListEventHandler, ItemListResponseHandler {
    weak var viewController: ItemListViewModelHandler!
    var interactor: ItemListRequestHandler!
    var wireframe: ItemListWireframe!
    var viewModel = ItemListViewModel()

    var dataSource = TableViewDataSource<DataSourceItem>()
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fetchedRC: NSFetchedResultsController<POI>!

    init() {

        dataSource.onTableViewDidSetFunction = { (tableView) in
            tableView?.rowHeight = UITableViewAutomaticDimension
            tableView?.estimatedRowHeight = 44

            tableView?.register(UINib.init(nibName: "ItemListCell", bundle: nil), forCellReuseIdentifier: "cell")
        }

        dataSource.heightForRowFunction = { (tableView, indexPath, item) in
            return UITableViewAutomaticDimension
        }

        dataSource.cellForRowFunction = {(tableView, indexPath, item) in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ItemListCell else {
                return UITableViewCell()
            }
            guard let viewModel = item.value as? ItemListCellViewModel else {
                return UITableViewCell()
            }
            cell.viewModel = viewModel
            return cell
        }

        dataSource.didSelectRowFunction = { [weak self] (tableView, indexPath, item) in
            guard let strongSelf = self, let viewModel = item.value as? ItemListCellViewModel else {
                return
            }

            Logger.info("ListItemViewModel pressed: \(viewModel.title.value)")
            strongSelf.wireframe.pushItemDetailView(viewModel.POIIdentifier.value)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    //
    func search(_ txt: String) {
        interactor.itemListPresenterRequestsGetSearchedItems(txt, forceUpdate: false)
    }

    func refresh() {
        context = appDelegate.persistentContainer.viewContext
        let request = POI.fetchRequest() as NSFetchRequest<POI>
        let sort = NSSortDescriptor(key: #keyPath(POI.title), ascending: true)
        request.sortDescriptors = [sort]
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedRC.performFetch()
            var POIs = [POIEntity]()
            for data in fetchedRC.fetchedObjects! {
                let poi = POIEntity()
                poi.id = (data.id?.stringValue)!
                poi.title = data.title!
                poi.geocoordinates = data.coordinates ?? ""
                POIs.append(poi)
            }
            viewModel.items = POIs.map(POIToItemListCellViewModelMapping)
            let rows = viewModel.items.map { (POIEntityModel) -> DataSourceItem in
                return DataSourceItem(POIEntityModel, "\(POIEntityModel.POIIdentifier.value)")
            }
            self.dataSource.addItems(rows)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if fetchedRC.fetchedObjects?.count == 0 {
            interactor.itemListPresenterRequestsGetItems(false)
        }
    }

    func reloadData() {
        interactor.itemListPresenterRequestsGetItems(true)
    }

    func itemListViewDidPressMenuButton() {
        self.wireframe.showNavigationDrawer()
        interactor.itemListPresenterRequestsOpenMenu()
    }

    // MARK: ItemListViewHandler
    func itemListViewWillAppear() {
        //interactor.itemListPresenterRequestsGetItems(false)
        refresh()
    }

    func itemListPullToRefreshReceived() {
        interactor.itemListPresenterRequestsGetItems(true)
    }

    // MARK: ItemListInteractorHandler
    func requestGetPOIsDidStart() {
        self.viewController.animatePullToRefreshLoading(show: true)
    }

    func requestGetPOIsDidFinish(_ result: GetPOIsEntity) {
        switch result {
        case let .success(POIs):
            //map entities to view models
            viewModel.items = POIs.map(POIToItemListCellViewModelMapping)

            //add the view models creating DataSourceItems
            let rows = viewModel.items.map { (POIEntityModel) -> DataSourceItem in
                return DataSourceItem(POIEntityModel, "\(POIEntityModel.POIIdentifier.value)")
            }

            self.dataSource.addItems(rows)
            for data in viewModel.items {
                let poi = POI(entity: POI.entity(), insertInto: context)
                poi.id = NSNumber(value: Int(data.POIIdentifier.value)!)
                poi.title = data.title.value
                poi.coordinates = data.geocoordinates.value
                appDelegate.saveContext()
            }
            self.viewController.animatePullToRefreshLoading(show: false)
            refresh()

        case let .searchSuccess(POIs):
            //map entities to view models
            viewModel.items.removeAll()
            viewModel.items = POIs.map(POIToItemListCellViewModelMapping)

            //add the view models creating DataSourceItems
            let rows = viewModel.items.map { (POIEntityModel) -> DataSourceItem in
                return DataSourceItem(POIEntityModel, "\(POIEntityModel.POIIdentifier.value)")
            }

            self.dataSource.resetItems(rows)
            self.viewController.animatePullToRefreshLoading(show: false)
        case .connectionError:
            self.viewController.showErrorFeedback("connection_error".localized())
            self.viewController.animatePullToRefreshLoading(show: false)
        case .unknownError:
            self.viewController.showErrorFeedback("unknown_error".localized())
            self.viewController.animatePullToRefreshLoading(show: false)
        }
    }
}
