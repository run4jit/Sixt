//
//  BaseApiService.swift
//  Sixt
//
//  Created by Ranjeet on 25/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit
import Foundation

class BaseApiService: NSObject {
    internal let service: NetworkServiceType
    internal var task: URLSessionTask?
    init(service: NetworkServiceType = NetworkService.share) { //Dependency Injection
        self.service = service
    }
    
    func cancelTask() {
        self.task?.cancel()
    }
}
