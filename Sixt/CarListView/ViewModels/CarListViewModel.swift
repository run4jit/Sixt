//
//  CarListViewModel.swift
//  Sixt
//
//  Created by Ranjeet on 24/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

protocol CarListViewModelProtocol {
    func carCellDidTapped(carListViewModel: CarListViewModel, car: Car) -> Void
    func updateCarTableView(carListViewModel: CarListViewModel) -> Void
}


class CarListViewModel: NSObject {
    fileprivate var cars = [Car]()
    var carListViewModelProtocol: CarListViewModelProtocol?
    
    override init() {
        super.init()
    }
    
    func featchCarInfo() {
        CarManager.manager.getCarList(cached: true) {[weak self] (cars) in
            guard let strongSelf = self else { return }
            strongSelf.cars = cars
            strongSelf.carListViewModelProtocol?.updateCarTableView(carListViewModel: strongSelf)
        }
    }

    var totalCarCount: Int {
        get {
        return self.cars.count;
        }
    }
}


extension CarListViewModel: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = self.cars[indexPath.row]
        self.carListViewModelProtocol?.carCellDidTapped(carListViewModel: self, car: car)

    }
}

extension CarListViewModel: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CarTableViewCell", for: indexPath) as? CarTableViewCell else {
            return UITableViewCell()
        }
        let car = self.cars[indexPath.row]
        cell.updateView(car: car)
        return cell
    }
}
