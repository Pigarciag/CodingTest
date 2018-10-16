//
//  MappingPOIEntities.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/02/17.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation
import T21Mapping

func POIToItemListCellViewModelMapping(POIEntity: POIEntity) -> ItemListCellViewModel {
    let viewModel = ItemListCellViewModel()
    viewModel.geocoordinates.value = POIEntity.geocoordinates
    viewModel.title.value = POIEntity.title
    viewModel.POIIdentifier.value = POIEntity.id
    return viewModel
}
