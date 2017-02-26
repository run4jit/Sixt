//
//  Car.swift
//  Sixt
//
//  Created by test on 2/23/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
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



struct Car {
    enum CarTransmission: String {
        case auto = "A"
        case manual = "M"
        
        func transmission() -> String {
            switch self {
            case .auto:
                return "Auto"
            case .manual:
                return "Manual"
            }
        }
    }

    enum CarFule: String {
        case diesel = "D"
        case petrol = "P"
        
        func fule() -> String {
            switch self {
            case .diesel:
                return "Diesel"
            case .petrol:
                return "Petrol"
            }
        }
    }

    private let id: String
    private let modelIdentifier: String
    private let modelName: String
    private let name: String
    private let maker: String
    private let group: String
    private let color: String
    private let series: String
    private let fuelType: CarFule
    private let fuelLevel: Double
    private let transmissionType: CarTransmission
    private let licensePlate: String
    private let latitude: CLLocationDegrees
    private let longitude: CLLocationDegrees
    private let innerCleanliness: String
    private let carImageUrl: String
    init(id: String = "",
         modelIdentifier: String = "",
         modelName: String,
         name: String,
         maker: String,
         group: String = "",
         color: String = "midnight_black",
         series: String = "",
         fuelType: CarFule = .diesel,
         fuelLevel: Double = 0,
         transmissionType: CarTransmission = .manual,
         licensePlate: String = "",
         latitude: CLLocationDegrees = 0,
         longitude: CLLocationDegrees = 0,
         innerCleanliness: String = "",
         carImageUrl: String
        ) {
        self.id = id
        self.modelIdentifier = modelIdentifier
        self.modelName = modelName
        self.name = name
        self.maker = maker
        self.group = group
        self.color = color
        self.series = series
        self.fuelType = fuelType
        self.fuelLevel = fuelLevel
        self.transmissionType = transmissionType
        self.licensePlate = licensePlate
        self.latitude = latitude
        self.longitude = longitude
        self.innerCleanliness = innerCleanliness
        self.carImageUrl = carImageUrl
    }
    
    public var numberPlate: String {
        get {
            return licensePlate
        }
    }
    
    public var transmission: String {
        get {
            return transmissionType.transmission()
        }
    }
    
    public var model: String {
        get {
            return modelName
        }
    }
    
    public var fuel: String {
        get {
            return self.fuelType.fule()
        }
    }
    
    public var carGroup: String {
        get {
            return group
        }
    }
    
    public var carFuelLevel: Float {
        get {
            return Float(fuelLevel)
        }
    }

    
    public var ownerName: String {
        get {
            return name.capitalized
        }
    }
    
    public var carColor: String {
        get {
            return color
        }
    }
    
    public var imageUrl: String {
        return "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/\(self.modelIdentifier)/\(self.color)/2x/car.png"
    }

    public var location: CLLocationCoordinate2D {
       return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Car: Serialize {
    static func serializer(json: AnyObject) -> Car? {
        
        guard let jsonObject = json as? [String: AnyObject] else { return nil }
        let id = jsonObject["id"] as? String ?? ""
        let modelIdentifier = jsonObject["modelIdentifier"] as? String ?? ""
        guard let modelName = jsonObject["modelName"] as? String else { return nil }
        guard let name = jsonObject["name"] as? String else { return nil }
        guard let maker = jsonObject["make"] as? String else { return nil }
        let group = jsonObject["group"] as? String ?? ""
        let color = jsonObject["color"] as? String ?? "midnight_black"
        let series = jsonObject["series"] as? String ?? ""
        let fuel = jsonObject["fuelType"] as? String ?? ""
        let fuelType = CarFule(rawValue: fuel) ?? .diesel
        let level = jsonObject["fuelLevel"] as? NSNumber ?? NSNumber.init(value: 0)
        let fuelLevel = level.doubleValue
        guard let transmission = jsonObject["transmission"] as? String else { return nil }
        let transmissionType = CarTransmission(rawValue: transmission) ?? .manual

        guard let licensePlate = jsonObject["licensePlate"] as? String else { return nil }
        let lat = jsonObject["latitude"] as? NSNumber ?? NSNumber.init(value: 47.3437)
        let latitude = lat.doubleValue
        let long = jsonObject["longitude"] as? NSNumber ?? NSNumber.init(value: 11.3591)
        let longitude = long.doubleValue
        let innerCleanliness = jsonObject["innerCleanliness"] as? String ?? ""
        let carImageUrl = jsonObject["carImageUrl"] as? String ?? ""
        
        
        return Car(id: id
            , modelIdentifier: modelIdentifier
            , modelName: modelName
            , name: name
            , maker: maker
            , group: group
            , color: color
            , series: series
            , fuelType: fuelType
            , fuelLevel: fuelLevel
            , transmissionType: transmissionType
            , licensePlate: licensePlate
            , latitude: latitude
            , longitude: longitude
            , innerCleanliness: innerCleanliness
            , carImageUrl: carImageUrl)
        
    }
}
