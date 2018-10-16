//
//  ItemListCell.swift
//  MyApp
//
//  Created by Eloi Guzmán Cerón on 17/05/2017.
//  Copyright © 2017 Worldline. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import T21RxAdditions

class ItemListCell: UITableViewCell {

    private(set) var disposeBag = DisposeBag()

    @IBOutlet weak var labelTitle: UILabel?

    var viewModel = ItemListCellViewModel() {
        didSet {
            disposeBag = DisposeBag()
            bindToObserver(variable: viewModel.title, observer: labelTitle?.rx.text, disposeBag: disposeBag)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
