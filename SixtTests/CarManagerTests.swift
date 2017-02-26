//
//  CarManagerTests.swift
//  Sixt
//
//  Created by Ranjeet on 27/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit
import XCTest
@testable import Sixt

class CarManagerTests: XCTestCase {
    fileprivate var cars: [Car] = []
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        getCarData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
 
    func getCarData() -> Void {
        let expect = expectation(description: "Car list donload should success")
        
        CarManager.manager.getCarList(cached: true) {[weak self] (cars) in
            guard let strongSelf = self else { return }
            strongSelf.cars = cars
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, "Test Time out to receive car info.\(error?.localizedDescription)")
        }
    }
    
    func testCar() -> Void {
        
        XCTAssertNotEqual(self.cars.count, 0)
        
        for car in self.cars {
            XCTAssertNotNil(car.ownerName, "Car name is nil")
            XCTAssertNotNil(car.carFuelLevel, "Car fule level is nil")
            XCTAssertNotNil(car.carColor, "Car color is nil")
            XCTAssertNotNil(car.location, "Car location is nil")
            XCTAssertNotNil(car.model, "Car model is nil")
            XCTAssertNotNil(car.fuel, "Car fule type is nil")
            XCTAssertNotNil(car.numberPlate, "Car licence is nil")
            XCTAssertNotNil(car.transmission, "Car transmission is nil")
            XCTAssertNotNil(car.carGroup, "Car Group is nil")
        }
    }
}
