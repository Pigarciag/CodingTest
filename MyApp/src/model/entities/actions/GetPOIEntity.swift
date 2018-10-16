//
//  GetPOIEntity.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 09/08/2017.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation

public enum GetPOIEntity {
    case success(POI: POIEntity)
    case connectionError
    case unknownError
}
