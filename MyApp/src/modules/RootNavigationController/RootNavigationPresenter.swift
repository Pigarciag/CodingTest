//
//  RootNavigationPresenter.swift
//  MyApp
//
//  Created by Jonattan Nieto Sánchez on 15/5/17.
//  Copyright (c) 2017 Worldline. All rights reserved.
//
//

import Foundation

// MARK: - Protocol to be defined at Presenter
protocol RootNavigationEventHandler: class {
    func handleViewWillAppearEvent()
    func handleViewWillDisappearEvent()
}

// MARK: - Protocol to be defined at Presenter
protocol RootNavigationResponseHandler: class {
    // func handle______Response()
}

// MARK: - Presenter Class must implement Protocols to handle ViewController Events and Interactor Responses
class RootNavigationPresenter: RootNavigationEventHandler, RootNavigationResponseHandler {

    // MARK: relationships
    weak var viewController: RootNavigationViewModelHandler?
    var interactor: RootNavigationRequestHandler!
    var wireframe: RootNavigationNavigationHandler!

    // MARK: EventsHandler Protocol Implementation
    func handleViewWillAppearEvent() {
            self.wireframe.showNavigationDrawer(true)
            self.wireframe.showItemListView(true)
    }

    func handleViewWillDisappearEvent() {

    }

    // MARK: ResponseHandler Protocol Implementation

    //func handle_____Response() {}

}
