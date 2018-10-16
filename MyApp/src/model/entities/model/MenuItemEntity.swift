//
//  MenuItemEntity.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 06/06/2017.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation

enum MenuItemType: String {
    case POIs = "POIs"
    case settings = "Settings"
}

struct MenuItemEntity {
    let identifier: String
    let title: String
}
