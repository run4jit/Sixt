//
//  LocationManager.swift
//  Sixt
//
//  Created by test on 2/24/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    var currentLocation:CLLocation?
    private var locationManager:CLLocationManager?
    var lastLocation:CLLocation?
    static let manager = LocationManager()
    
    private override init() {
        super.init()
        self.setupLocationManager()
    }
    
    private func setupLocationManager() {
        //Setting of location manager
        locationManager = nil
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        //updation will be checked only app in active state
        locationManager?.requestWhenInUseAuthorization()
        self.enableLocationManager()
    }
    
    ///enable the location manager to start Updating Location
    private func enableLocationManager() {
        locationManager?.startUpdatingLocation()
    }
    
    ///stop the location manger update
    private func disableLocationManager() {
        locationManager?.stopUpdatingLocation()
        locationManager?.delegate = nil
        locationManager = nil
    }
    
    func isLocationEnabledInDevice() -> Bool {
        return CLLocationManager.locationServicesEnabled() && isAuthorizedToUse()
    }
    
    func isAuthorizedToUse() -> Bool{
        switch(CLLocationManager.authorizationStatus()) {
        case .notDetermined, .restricted, .denied:
            return false
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        }
    }

    //MARK:- CLLocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        lastLocation = locations.last
        currentLocation = lastLocation
        //stop updating the location to save the battery power
        disableLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse,.authorizedAlways:
            self.enableLocationManager()
        case .denied, .restricted, .notDetermined :
            self.locationManager?.requestWhenInUseAuthorization()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location manager did fail error is ----> \(error.localizedDescription)")
    }

}
