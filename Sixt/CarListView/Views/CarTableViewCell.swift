//
//  CarTableViewCell.swift
//  Sixt
//
//  Created by test on 2/23/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit


class CarTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    static let placeHolderImage = UIImage(named: "canMarkerIcon")

    func updateView(car: Car) {
        clearView()
        nameLabel.text = car.ownerName
        modelLabel.text = car.model
        carImageView.image = CarTableViewCell.placeHolderImage
        CarManager.manager.getCarImage(url: car.imageUrl) {[weak self] (image) in
            guard let strongSelf = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    strongSelf.carImageView.image = image
                }
            }
        }
    }
    private func clearView() {
        nameLabel.text = nil
        modelLabel.text = nil
        carImageView.image = nil
    }
}
