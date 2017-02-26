//
//  CarListService.swift
//  Sixt
//
//  Created by Ranjeet on 24/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import Foundation

class CarListService: BaseApiService {
    private let apiName = "http://www.codetalk.de/cars.json"
    
    func carList(complition:@escaping carListCallBack) -> Void {
        guard let request = request(apiName: apiName) else { complition([]); return }
        
        self.task = service.send(request: request)
        {[weak self] (data:Data?, response: URLResponse?, error: Error?) in
            guard let strongSelf = self else { complition([]); return }
            if error == nil && data != nil{ //Success
                strongSelf.handleSuccess(data: data!, response: response, complition: complition)
            } else { //Fail
                strongSelf.handleFailure(error: error!, response: response, complition: complition)
            }
        }
    }
    
    private func handleSuccess(data: Data, response: URLResponse?, complition:@escaping (([Car]) -> Void))
    {
        if let response = response as? HTTPURLResponse  {
            if isStatusSuccess(response: response) {
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<AnyObject>, let jsonArray = jsonObject {
                    var cars = [Car]()
                    for json in jsonArray {
                        if let car = Car.serializer(json: json) {
                            cars.append(car)
                        }
                    }
                    DispatchQueue.main.async {
                        complition(cars)
                    }
                    return // return from here
                }
                DispatchQueue.main.async {
                    complition([]) // Json is empty or not array of car object then should return empty car list
                }
            }
        }
    }
    
    //TODO: handle failure due to many region, For now sending empty car list
    private func handleFailure(error: Error, response: URLResponse?, complition:@escaping (([Car]) -> Void))
    {
        DispatchQueue.main.async {
            complition([])
        }
    }
}
