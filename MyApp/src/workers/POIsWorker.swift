//
//  POIsWorker.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 22/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import Foundation
import T21RealmStoreSwift
import RealmSwift
import Result

protocol POIsWorker {
    func requestGetPOIs( _ completion: @escaping ( _ result: GetPOIsEntity) -> Void)
    func requestGetPOI( _ POIIdentifier: POIIdentifier, _ completion: @escaping ( _ result: GetPOIEntity) -> Void)
    func queryGetPOIs(_ completion: @escaping ( _ results: [POIEntity]) -> Void)
    func queryGetPOI( _ id: POIIdentifier) -> POIEntity?
}

class POIsWorkerImp: POIsWorker {

    public func requestGetPOIs(_ completion: @escaping ( _ result: GetPOIsEntity) -> Void) {

        let poisRepository = SharedContainer().resolved(POIsRepository.self)
        poisRepository.requestGetPOIs({ (response: GetPOIsResponseDTO) -> Void in
            switch response {
            case let .success(dto):
                let provider = SharedContainer().resolved(DBProvider.self)
                provider.realmStore.write({ (_ realm: Realm) in
                    let entities = dto.response.results.map({ (POIDTO) -> POIEntity in
                        let POI: POIEntity = realm.getOrCreateObject(POIDTO.id)
                        POI.geocoordinates = POIDTO.geocoordinates
                        POI.title = POIDTO.title
                        return POI
                    })
                    let result: [POIIdentifier] = RealmStore.getPrimaryKeys(entities)
                    return result
                }, { (result: RealmStoreResult<[POIIdentifier]>) -> Void in
                    if let realm = result.realm, let primaryKeys = result.value {
                        completion(GetPOIsEntity.success(poi: realm.getObjects(primaryKeys)))
                    } else {
                        completion(GetPOIsEntity.unknownError)
                    }
                })
            case .mappingFailed:
                completion(GetPOIsEntity.unknownError)
            case .error:
                completion(GetPOIsEntity.connectionError)
            }
        })
    }

    public func requestGetPOI( _ POIIdentifier: POIIdentifier, _ completion: @escaping ( _ result: GetPOIEntity) -> Void) {

        let poisRepository = SharedContainer().resolved(POIsRepository.self)
        poisRepository.requestGetPOI(POIIdentifier, { (response: GetPOIResponseDTO) in
            switch response {
            case let .success(dto):
                let provider = SharedContainer().resolved(DBProvider.self)
                provider.realmStore.write({ (_ realm: Realm) in
                    let POIDTO = dto.response
                    let POI: POIEntity = realm.getOrCreateObject(POIDTO.id)
                    POI.title = POIDTO.title
                    POI.geocoordinates = POIDTO.geocoordinates
                    POI.address = POIDTO.address
                    POI.transport = POIDTO.transport
                    POI.url = POIDTO.url
                    POI.poiDescription = POIDTO.poiDescription
                    POI.contact = POIDTO.contact
                    return POI.id
                }, { (result: RealmStoreResult<POIIdentifier>) -> Void in
                    if let realm = result.realm, let primaryKey = result.value {
                        completion(GetPOIEntity.success(POI: realm.getOrCreateObject(primaryKey)))
                    } else {
                        completion(GetPOIEntity.unknownError)
                    }
                })
            case .mappingFailed:
                completion(GetPOIEntity.unknownError)
            case .error:
                completion(GetPOIEntity.connectionError)
            }
        })
    }

    public func queryGetPOIs(_ completion: @escaping ( _ results: [POIEntity]) -> Void) {
        let provider = SharedContainer().resolved(DBProvider.self)
        provider.realmStore.read({ (_ realm: Realm) -> ([POIIdentifier]) in
            let objects: [POIEntity] = realm.getAllObjects()
            return RealmStore.getPrimaryKeys(objects)
        }, { ( _ result: RealmStoreResult<[POIIdentifier]>) -> Void in
            if let realm = result.realm, let primaryKeys = result.value {
                completion(realm.getObjects(primaryKeys))
            } else {
                completion([])
            }
        })
    }

    public func queryGetPOI( _ id: POIIdentifier) -> POIEntity? {
        let provider = SharedContainer().resolve(DBProvider.self)!
        let results: [POIEntity] = (try? provider.realmStore.realm().getObjects([id])) ?? []
        return results.first
    }
}
