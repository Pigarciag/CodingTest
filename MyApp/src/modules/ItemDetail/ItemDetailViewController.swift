//
//  ItemDetailVC.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 21/12/16.
//  Copyright © 2016 Worldline. All rights reserved.
//

import UIKit
import T21RxAdditions

// MARK: - Protocol to be defined at ViewController

protocol ItemDetailViewModelHandler: class {
    //That part should be implemented with RxSwift.
}

class ItemDetailViewController: UIViewController, ItemDetailViewModelHandler, NavigationBarBackButtonItemProtocol {
    var presenter: ItemDetailPresenter!

    @IBOutlet
    weak var labelDetailTitle: UILabel?

    @IBOutlet
    weak var labelTitle: UILabel?

    @IBOutlet
    weak var labelCoordinates: UILabel?

    @IBOutlet
    weak var labelAddress: UILabel?

    @IBOutlet
    weak var labelTransport: UILabel?

    @IBOutlet
    weak var labelURL: UILabel?

    @IBOutlet
    weak var textDescription: UITextView?

    @IBOutlet
    weak var labelContact: UILabel?

    var viewModel: ItemDetailViewModel {
        return presenter.viewModel
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        Logger.info("Load Item Detail View")
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = NavigationBarItemsFactory.createBackButtonItem(self)
        configureBindings()
    }

    func configureBindings() {
        labelDetailTitle?.text = "Point of interest detail:"
        viewModel.title => labelTitle!.rx.text
        viewModel.geocoordinates => labelCoordinates!.rx.text

        bindOnNext(viewModel.geocoordinates) { [weak self] (geocoordinates) -> Void in
            self?.labelCoordinates?.text = "Geocoordinates: \(geocoordinates)"
        }

        bindOnNext(viewModel.address) { [weak self] (address) -> Void in
            if !address.isEmpty {
                self?.labelAddress?.isHidden = false
                self?.labelAddress?.text = "Address: \(address)"
            } else {
                self?.labelAddress?.isHidden = true
            }
        }

        bindOnNext(viewModel.transport) { [weak self] (transport) -> Void in
            if !transport.isEmpty {
                self?.labelTransport?.isHidden = false
                self?.labelTransport?.text = "Transport: \(transport)"
            } else {
                self?.labelTransport?.isHidden = true
            }
        }

        bindOnNext(viewModel.url) { [weak self] (url) -> Void in
            if !url.isEmpty {
                self?.labelURL?.isHidden = false
                self?.labelURL?.text = "Web page: \(url)"
            } else {
                self?.labelURL?.isHidden = true
            }
        }

        bindOnNext(viewModel.contact) { [weak self] (contact) -> Void in
            if !contact.isEmpty {
                self?.labelContact?.isHidden = false
                self?.labelContact?.text = "Contact: \(contact)"
            } else {
                self?.labelContact?.isHidden = true
            }
        }

        bindOnNext(viewModel.description) { [weak self] (description) -> Void in
            if !description.isEmpty {
                self?.textDescription?.isHidden = false
                self?.textDescription?.text = description
            } else {
                self?.textDescription?.isHidden = true
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.itemListDetailViewWillAppear()
    }

    // MARK: ItemDetailViewInterface

    // MARK: NavigationBarBackButtonItemProtocol
    public func navigationBarBackButtonPressed() {
        self.presenter.itemListDetailDidPressBackButton()
    }

}
