//
//  NavigationDrawerViewController.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import Material

class NavigationDrawerViewController: NavigationDrawerController {
    var presenter: NavigationDrawerPresenter?

    public override func viewDidLoad() {
        Logger.info("Load Navigation Drawer View")
        super.viewDidLoad()
    }
}
