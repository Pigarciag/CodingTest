//
//  ItemDetailWireframe.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 21/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocol to be defined at Wireframe

protocol ItemDetailNavigationHandler: class {
    // Include methods to present or dismiss
    func popItemDetailView()
}

class ItemDetailWireframe {

    weak var viewController: ItemDetailViewController?

    public func popItemDetailView() {
        _ = viewController?.navigationController?.popViewController(animated: true)
    }
}
