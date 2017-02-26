//
//  CarManager.swift
//  Sixt
//
//  Created by Ranjeet on 24/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

class CarManager: NSObject {
    static let manager = CarManager()
    private var carListService = CarListService()
    private var carImageService = CarImageService()
    var cars = [Car]()
    private override init() {
        super.init()
    }
    
    //Mark:- Get Car List
    func getCarList(cached: Bool, complition: @escaping (([Car]) -> Void)) {
        if (cached == false) || (self.cars.count == 0) {
            carListService.carList { (cars: [Car]) in
                self.cars = cars;
                DispatchQueue.main.async {
                    complition(cars)
                }
            }
            return
        }
        complition(self.cars)
    }
    
    //MARK:- Get Car Image
    func getCarImage(url: String, complition: @escaping ((UIImage?) -> Void)) {
        self.carImageService.carImage(imageUrl: url) { (image) in
            DispatchQueue.main.async {
                complition(image)
            }
        }
    }
    
    //MARK:- Cancel Services
    private func cancelService(service: BaseApiService)
    {
        service.cancelTask()
    }
    
    func cancelCarListRequst() {
        cancelService(service: self.carListService)
    }
    
    func cancelImageRequst() {
        cancelService(service: self.carImageService)
    }

}
