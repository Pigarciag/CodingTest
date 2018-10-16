//
//  NavigationBarItemsFactory.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 01/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

@objc
protocol NavigationBarBackButtonItemProtocol: class {
    @objc
    func navigationBarBackButtonPressed()
}

@objc
protocol NavigationBarDrawerMenuButtonItemProtocol: class {
    @objc
    func navigationBarDrawerMenuButtonPressed()
}

class NavigationBarItemsFactory {

    static public func createBackButtonItem(_ delegate: NavigationBarBackButtonItemProtocol) -> UIBarButtonItem {
        //let image = UIImage(named: "todo: backButton")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        //let button = UIBarButtonItem(image: image,
        //                             style: UIBarButtonItemStyle.plain,
        //                            target: delegate,
        //                            action: #selector(NavigationBarBackButtonItemProtocol.navigationBarBackButtonPressed))
        let button = UIBarButtonItem(title: "Back",
                                     style: UIBarButtonItemStyle.plain,
                                     target: delegate,
                                     action: #selector(NavigationBarBackButtonItemProtocol.navigationBarBackButtonPressed))
        return button
    }

    static public func createDrawerMenuButtonItem(_ delegate: NavigationBarDrawerMenuButtonItemProtocol) -> UIBarButtonItem {
        //let image = UIImage(named: "todo: drawerMenuButton")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        //let button = UIBarButtonItem(image: image,
        //                             style: UIBarButtonItemStyle.plain,
        //                             target: delegate,
        //                             action: #selector(NavigationBarDrawerMenuButtonItemProtocol.navigationBarDrawerMenuButtonPressed))
        let button = UIBarButtonItem(title: "Menu",
                                     style: UIBarButtonItemStyle.plain,
                                     target: delegate,
                                     action: #selector(NavigationBarDrawerMenuButtonItemProtocol.navigationBarDrawerMenuButtonPressed))
        return button
    }
}
