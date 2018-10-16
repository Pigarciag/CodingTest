//
//  DBStore.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 21/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import T21RealmStoreSwift

public protocol DBProvider {
    var realmStore: RealmStore { get }
}

public class DBProviderImp: DBProvider {

    init() {

    }

    public private(set) var realmStore = RealmStore()
}
