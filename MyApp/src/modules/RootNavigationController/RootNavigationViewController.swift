//
//  RootNavigationViewController.swift
//  MyApp
//
//  Created by Jonattan Nieto Sánchez on 15/5/17.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation
import UIKit

// MARK: - Protocol to be defined at ViewController
protocol RootNavigationViewModelHandler: class {
    //That part should be implemented with RxSwift.
}

// MARK: - ViewController Class must implement ViewModelsHandler Protocol to handle ViewModel from Presenter
class RootNavigationViewController: UINavigationController, RootNavigationViewModelHandler {
    // MARK: relationships
    var presenter: RootNavigationEventHandler!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarHidden(false, animated: false)
    }

    // MARK: View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.handleViewWillAppearEvent()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.handleViewWillDisappearEvent()
    }
}
