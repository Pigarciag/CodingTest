//
//  SettingsViewController.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 06/06/2017.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: - Protocol to be defined at ViewController

protocol SettingsViewModelHandler: class {
    //That part should be implemented with RxSwift.
}

// MARK: - ViewController Class must implement ViewModelHandler Protocol to handle ViewModel from Presenter
class SettingsViewController: UIViewController, SettingsViewModelHandler {
    // MARK: relationships
    var presenter: (SettingsEventHandler & NavigationBarDrawerMenuButtonItemProtocol)!

    var viewModel: SettingsViewModel {
        return presenter.viewModel
    }

    // MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = NavigationBarItemsFactory.createDrawerMenuButtonItem(presenter)

        configureBindings()
    }

    func configureBindings() {
        //Add the ViewModel bindings here ...
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.handleViewWillAppearEvent()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.handleViewWillDisappearEvent()
    }
}
