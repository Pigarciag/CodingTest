//
//  LastUpdateTimeEntity.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 22/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import RealmSwift

class LastUpdateTimeEntity: Object {
    @objc dynamic var lastSuccesfulUpdate: Date = Date.distantPast
    @objc dynamic var uid: String = ""

    override static func primaryKey() -> String? {
        return "uid"
    }
}
