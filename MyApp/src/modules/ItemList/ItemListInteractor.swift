//
//  ItemListInteractor.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import T21RealmStoreSwift
import RealmSwift

// MARK: - Protocol to be defined at Interactor
protocol ItemListRequestHandler: class {
    // func handle______Request()
    func itemListPresenterRequestsOpenMenu()
    func itemListPresenterRequestsGetItems( _ forceUpdate: Bool)
    func itemListPresenterRequestsGetSearchedItems( _ txt: String, forceUpdate: Bool)
}

class ItemListInteractor: NSObject, ItemListRequestHandler {
    weak var presenter: ItemListResponseHandler!

    // MARK: ItemListInteractorHandler
    func itemListPresenterRequestsOpenMenu() {

        SharedContainer().resolved(UseCaseNotifierProvider.self).notifier.notify { (obs: UseCaseNotifierProtocol) in
            obs.useCaseTriggered(UseCaseNotificationEntity.toggleDrawerMenu)
        }
    }

    public func itemListPresenterRequestsGetItems( _ forceUpdate: Bool = false) {
        let worker = SharedContainer().resolved(POIsWorker.self)
        worker.queryGetPOIs({ (results: [POIEntity]) in
            self.presenter.requestGetPOIsDidFinish(GetPOIsEntity.success(poi: results))
            self.requestGetPOIsIfCacheExpired(forceUpdate)
        })
    }

    public func itemListPresenterRequestsGetSearchedItems( _ txt: String, forceUpdate: Bool = false) {
        let worker = SharedContainer().resolved(POIsWorker.self)
        var items = [POIEntity]()
        worker.queryGetPOIs({ (results: [POIEntity]) in
            for POIEntity in results {
                if POIEntity.title.contains(txt) {
                    items.append(POIEntity)
                }
            }
            self.presenter.requestGetPOIsDidFinish(GetPOIsEntity.searchSuccess(poi: items))
        })
    }

    private func requestGetPOIsIfCacheExpired( _ forceUpdate: Bool = false) {
        if !forceUpdate {
            let worker = SharedContainer().resolved(LastUpdatesWorker.self)
            worker.getOrCreateLastUpdate(LastUpdate.getPOIs.rawValue, { (_ lastUpdate: LastUpdateTimeEntity) in
                //if POIs cache has expired perform request
                if self.cacheExpired(lastUpdate) {
                    self.requestGetPOIs()
                }
            })
        } else {
            self.requestGetPOIs()
        }
    }

    private func requestGetPOIs() {

        self.presenter.requestGetPOIsDidStart()
        let poisWorker = SharedContainer().resolved(POIsWorker.self)
        poisWorker.requestGetPOIs { (entity: GetPOIsEntity) -> Void in
            switch entity {
            case .success:
                let lastUpdateWorker = SharedContainer().resolved(LastUpdatesWorker.self)
                lastUpdateWorker.saveLastSuccessfulUpdate(LastUpdate.getPOIs.rawValue, Date(), {
                    //send results to the
                    poisWorker.queryGetPOIs({ (results: [POIEntity]) in
                        self.presenter.requestGetPOIsDidFinish(GetPOIsEntity.success(poi: results))
                    })
                })
            case .searchSuccess:
                Logger.info("No items searched")
            case .connectionError:
                self.presenter.requestGetPOIsDidFinish(GetPOIsEntity.connectionError)
            case .unknownError:
                self.presenter.requestGetPOIsDidFinish(GetPOIsEntity.unknownError)
            }
        }
    }

    private func cacheExpired(_ lastUpdate: LastUpdateTimeEntity) -> Bool {
        let lastDate = lastUpdate.lastSuccesfulUpdate.addingTimeInterval(LastUpdateDefaultCacheExpiration)
        return Date().compare(lastDate) == ComparisonResult.orderedDescending
    }
}
