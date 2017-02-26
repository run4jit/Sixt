//
//  CarAnnotation.swift
//  Sixt
//
//  Created by test on 2/24/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit
import MapKit

class CarAnnotation:NSObject, MKAnnotation {
    var car: Car
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(car: Car) {
        self.car = car
        self.coordinate = car.location
        self.title = car.ownerName
        self.subtitle = car.model
    }
}
