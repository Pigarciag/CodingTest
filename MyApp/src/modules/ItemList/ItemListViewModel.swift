//
//  ListItemViewModel.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 19/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import RxSwift

struct ItemListViewModel {
    var items: [ItemListCellViewModel] = []
}

struct ItemListCellViewModel {
    let POIIdentifier = Variable<String>("")
    let title = Variable<String>("")
    let geocoordinates = Variable<String>("")
}
