//
//  POIDTO.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 01/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import Marshal

public class POIDTO: Unmarshaling {

    public var id = ""
    public var title = ""
    public var geocoordinates = ""

    public var address: String? = ""
    public var transport: String? = ""
    public var url: String? = ""
    public var poiDescription: String? = ""
    public var contact: String? = ""

    public required init(object: MarshaledObject) throws {
        id = try object.value(for: "id")
        title = try object.value(for: "title")
        geocoordinates = try object.value(for: "geocoordinates")
        address = try object.value(for: "address")
        transport = try object.value(for: "transport")
        url = try object.value(for: "email")
        poiDescription = try object.value(for: "description")
        contact = try object.value(for: "phone")
    }
}
