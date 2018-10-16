//
//  GetPOIsEntity.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 20/02/17.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation

public enum GetPOIsEntity {
    case success(poi: [POIEntity])
    case searchSuccess(poi: [POIEntity])
    case connectionError
    case unknownError
}
