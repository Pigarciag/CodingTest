//
//  DrawerMenuCell.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 06/06/2017.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import UIKit

class DrawerMenuCell: UITableViewCell {

    var viewModel = DrawerMenuCellViewModel() {
        didSet {
            textLabel?.text = viewModel.title
        }
    }
}
