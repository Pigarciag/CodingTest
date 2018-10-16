//
//  ContainerProvider.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 09/06/2017.
//  Copyright © 2017 Worldline. All rights reserved.
//

import Foundation
import Swinject

public func SharedContainer() -> Container {
    return AppContainer.sharedInstance.container
}

public class AppContainer {

    public static let sharedInstance = AppContainer()

    public var container: Container = Container()

    private init () {
        container = defaultContainer()
    }

    private func defaultContainer() -> Container {
        let container = Container()

        //providers
        container.register(HTTPProvider.self) { _ in return self.hTTPProvider }
        container.register(DBProvider.self) { _ in return self.dBProvider }
        container.register(UseCaseNotifierProvider.self) { _ in return self.useCaseNotifierProvider }

        //repositories
        container.register(POIsRepository.self) { _ in return self.poisRepository }

        //workers
        container.register(LastUpdatesWorker.self) { _ in return self.lastUpdatesWorker }
        container.register(POIsWorker.self) { _ in return self.poisWorker }

        return container
    }

    //injections
    private let hTTPProvider = HTTPProviderImp()
    private let dBProvider = DBProviderImp()
    private let useCaseNotifierProvider = UseCaseNotifierImp()

    private let poisRepository = POIsRepositoryImp()

    private let lastUpdatesWorker = LastUpdatesWorkerImp()
    private let poisWorker = POIsWorkerImp()

}

extension Container {

    /**
     * This method is actually the same as resolve but forcing the unwrapping of the Service (!)
     */
    public func resolved<Service>(
        _ serviceType: Service.Type) -> Service {
        return resolve(serviceType, name: nil)!
    }

}
