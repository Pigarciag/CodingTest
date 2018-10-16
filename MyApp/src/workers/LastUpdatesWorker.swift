//
//  LastUpdatesWorker.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 22/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import T21RealmStoreSwift
import RealmSwift

public let LastUpdateDefaultCacheExpiration: TimeInterval = 60.0 //one minute

public enum LastUpdate: String {
    case getPOIs
}

protocol LastUpdatesWorker {
    func saveLastSuccessfulUpdate(_ uid: String, _ date: Date, _ completion: @escaping () -> Void)
    func getOrCreateLastUpdate( _ uid: String, _ completion: @escaping (_ lastUpdate: LastUpdateTimeEntity) -> Void)
}

class LastUpdatesWorkerImp: LastUpdatesWorker {

    public func saveLastSuccessfulUpdate(_ uid: String, _ date: Date, _ completion: @escaping () -> Void) {
        let provider = SharedContainer().resolved(DBProvider.self)
        provider.realmStore.write({ (_ realm: Realm) -> Void in
            let obj: LastUpdateTimeEntity = realm.getOrCreateObject(uid)
            obj.lastSuccesfulUpdate = date
        }, { ( _ result: RealmStoreResult<Void>) -> Void in
            completion()
        })
    }

    public func getOrCreateLastUpdate( _ uid: String,
                                              _ completion: @escaping (_ lastUpdate: LastUpdateTimeEntity) -> Void) {
        let provider = SharedContainer().resolved(DBProvider.self)
        provider.realmStore.write({ (_ realm: Realm) -> (String) in
            let obj: LastUpdateTimeEntity = realm.getOrCreateObject(uid)
            let pk: String = obj.getPrimaryKey()!
            return pk
        }, { ( _ result: RealmStoreResult<String>) -> Void in
            let obj: LastUpdateTimeEntity? = result.realm!.object(ofType: LastUpdateTimeEntity.self, forPrimaryKey: result.value!)
            completion(obj!)
        })
    }
}
