//
//  POIEntity.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 19/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import RealmSwift

typealias POIIdentifier = String

public class POIEntity: Object {

    @objc dynamic var id: POIIdentifier = ""
    @objc dynamic var title = ""
    @objc dynamic var geocoordinates = ""

    @objc dynamic var address: String? = ""
    @objc dynamic var transport: String? = ""
    @objc dynamic var url: String? = ""
    @objc dynamic var poiDescription: String? = ""
    @objc dynamic var contact: String? = ""

    override public static func primaryKey() -> String? {
        return "id"
    }
}
