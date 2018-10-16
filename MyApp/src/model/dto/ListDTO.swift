//
//  ListDTO.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 01/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import Marshal

public class ListDTO<ItemClass: Unmarshaling> : Unmarshaling {
    public var count: Int = 0
    public var results: [ItemClass] = []

    public required init(object: MarshaledObject) throws {
        let items: [JSONObject] = try object.value(for: "list")
        for jsonItem in items {
            let item: ItemClass = try ItemClass(object: jsonItem)
            results.append(item)
        }
    }
}
