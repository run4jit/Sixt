//
//  CarDetailViewModel.swift
//  Sixt
//
//  Created by Ranjeet on 25/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

/*
 {
 "id": "WMWSW31030T222518",
 "modelIdentifier": "mini",
 "modelName": "MINI",
 "name": "Vanessa",
 "make": "BMW",
 "group": "MINI",
 "color": "midnight_black",
 "series": "MINI",
 "fuelType": "D",
 "fuelLevel": 0.7,
 "transmission": "M",
 "licensePlate": "M-VO0259",
 "latitude": 48.134557,
 "longitude": 11.576921,
 "innerCleanliness": "REGULAR",
 "carImageUrl": "https://de.drive-now.com/static/drivenow/img/cars/mini.png"
 }
 */
class CarDetailViewModel: NSObject {
    private let carSpecs = ["Name", "Model", "Group", "Fuel Type", "Fuel Level", "Transmission", "Car Number"]
    private let car: Car
    init(car: Car) {
        self.car = car
    }
}
