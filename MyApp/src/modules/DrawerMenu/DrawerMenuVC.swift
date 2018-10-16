//
//  DrawerMenuVC.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 28/11/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit

protocol DrawerMenuEventHandler {
    func viewWillAppear( _ animated: Bool)
}

class DrawerMenuVC: UIViewController {

    var presenter: DrawerMenuEventHandler!

    @IBOutlet
    weak var tableView: UITableView?

    public override func viewDidLoad() {
        Logger.info("Load Drawer Menu View")
        super.viewDidLoad()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated)
    }

}
