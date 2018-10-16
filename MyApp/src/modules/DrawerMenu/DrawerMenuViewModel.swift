//
//  DrawerMenuViewModelViewModel.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 06/06/2017.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation
import T21TableViewDataSource
import RxSwift
import RxCocoa

struct DrawerMenuViewModel {
    var items: Variable<[DrawerMenuCellViewModel]> = Variable([])
}

struct DrawerMenuCellViewModel: Hashable, DataSourceComparable {
    var title: String = ""
    var identifier: String = ""
    var index: Int = -1

    init ( _ identifier: String, _ title: String, _ index: Int) {
        self.identifier = identifier
        self.title = title
        self.index = index
    }

    init () { }

    public var hashValue: Int {
        return self.identifier.hashValue
    }
}

func == (lhs: DrawerMenuCellViewModel, rhs: DrawerMenuCellViewModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

func < (lhs: DrawerMenuCellViewModel, rhs: DrawerMenuCellViewModel) -> Bool {
    return lhs.index < rhs.index
}
