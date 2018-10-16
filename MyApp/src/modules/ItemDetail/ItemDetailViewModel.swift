//
//  ItemDetailViewModel.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 02/06/2017.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation
import RxSwift

struct ItemDetailViewModel {
    let title = Variable<String>("")
    let geocoordinates = Variable<String>("")
    let address = Variable<String>("")
    let transport = Variable<String>("")
    let url = Variable<String>("")
    let description = Variable<String>("")
    let contact = Variable<String>("")

}
