//
//  ItemDetailInteractor.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 21/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import Foundation

// MARK: - Protocol to be defined at Interactor

protocol ItemDetailRequestHandler: class {
    // func handle______Request()
    func requestPOI() -> POIEntity?
    func requestPOIDetails( _ completion: @escaping ( _ entity: GetPOIEntity) -> Void)
}

class ItemDetailInteractor: NSObject, ItemDetailRequestHandler {
    weak var presenter: ItemDetailResponseHandler!
    let itemId: POIIdentifier

    init ( _ itemId: POIIdentifier) {
        self.itemId = itemId
    }

    // MARK: ItemDetailInteractorInterface

    func requestPOI() -> POIEntity? {
        let worker = SharedContainer().resolved(POIsWorker.self)
        return worker.queryGetPOI(itemId)
    }

    func requestPOIDetails( _ completion: @escaping ( _ entity: GetPOIEntity) -> Void) {
        let worker = SharedContainer().resolved(POIsWorker.self)
        worker.requestGetPOI(itemId) { (entity: GetPOIEntity) in
            completion(entity)
        }
    }
}
