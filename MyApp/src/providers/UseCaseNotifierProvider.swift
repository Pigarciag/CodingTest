//
//  UseCaseNotifier.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 01/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import T21Notifier

protocol UseCaseNotifierProtocol {
    func useCaseTriggered(_ useCase: UseCaseNotificationEntity)
}

protocol UseCaseNotifierProvider {
    var notifier: T21Notifier<UseCaseNotifierProtocol> { get }
}

class UseCaseNotifierImp: UseCaseNotifierProvider {

    var notifier = T21Notifier<UseCaseNotifierProtocol>()
}
