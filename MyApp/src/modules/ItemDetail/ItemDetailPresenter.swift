//
//  ItemDetailPresenter.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 21/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import Foundation
import CoreData
import UIKit

protocol ItemDetailResponseHandler: class {
    // func handle______Response()
}

// MARK: - Protocol to be defined at Presenter
protocol ItemDetailEventHandler: class {
    var viewModel: ItemDetailViewModel { get }
    func itemListDetailDidPressBackButton()
    func itemListDetailViewWillAppear()
}

class ItemDetailPresenter: ItemDetailEventHandler, ItemDetailResponseHandler {
    weak var viewController: ItemDetailViewModelHandler!
    var interactor: ItemDetailInteractor!
    var wireframe: ItemDetailWireframe!
    var viewModel = ItemDetailViewModel()

    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fetchedRC: NSFetchedResultsController<POI>!
    private var selected: IndexPath!

    // MARK: ItemDetailViewHandler
    func itemListDetailDidPressBackButton() {
        wireframe?.popItemDetailView()
    }

    func itemListDetailViewWillAppear() {
        context = appDelegate.persistentContainer.viewContext
        let request = POI.fetchRequest() as NSFetchRequest<POI>
        let item = interactor.requestPOI()
        request.predicate = NSPredicate(format: "id = %@", (item?.id)!)
        let sort = NSSortDescriptor(key: #keyPath(POI.title), ascending: true)
        request.sortDescriptors = [sort]
        do {
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchedRC.performFetch()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        let pois = fetchedRC.fetchedObjects
        let poi = pois?.first
        if let item = interactor.requestPOI() {
            viewModel.title.value = item.title
            viewModel.geocoordinates.value = item.geocoordinates

            //request for extended POI information
            interactor.requestPOIDetails({ [weak self] (entity: GetPOIEntity) in
                switch entity {
                case let .success(POI):

                    if poi?.address != nil {
                        self?.viewModel.address.value = poi?.address ?? ""
                    } else {
                        self?.viewModel.address.value = POI.address ?? ""
                        poi?.address = self?.viewModel.address.value ?? ""
                    }
                    if poi?.transport != nil {
                        self?.viewModel.transport.value = poi?.transport ?? ""
                    } else {
                        self?.viewModel.transport.value = POI.transport ?? ""
                        poi?.transport = self?.viewModel.transport.value ?? ""
                    }
                    if poi?.url != nil {
                        self?.viewModel.url.value = poi?.url ?? ""
                    } else {
                        self?.viewModel.url.value = POI.url ?? ""
                        poi?.url = self?.viewModel.url.value ?? ""
                    }
                    if poi?.contact != nil {
                        self?.viewModel.contact.value = poi?.contact ?? ""
                    } else {
                        self?.viewModel.contact.value = POI.contact ?? ""
                        poi?.contact = self?.viewModel.contact.value ?? ""
                    }
                    if poi?.poiDescription != nil {
                        self?.viewModel.description.value = poi?.poiDescription ?? ""
                    } else {
                        self?.viewModel.description.value = POI.poiDescription ?? ""
                        poi?.poiDescription = self?.viewModel.description.value ?? ""
                    }
                    self?.appDelegate.saveContext()

                default:
                    self?.viewModel.address.value = poi?.address ?? ""
                    self?.viewModel.transport.value = poi?.transport ?? ""
                    self?.viewModel.url.value = poi?.url ?? ""
                    self?.viewModel.contact.value = poi?.contact ?? ""
                    self?.viewModel.description.value = poi?.poiDescription ?? ""
                }
            })
        }
    }
}
