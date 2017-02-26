//
//  CarImageService.swift
//  Sixt
//
//  Created by Ranjeet on 24/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import Foundation
import UIKit

var inMemoryCachedImage = [String:UIImage]()

class CarImageService: BaseApiService {
    
    func carImage(imageUrl: String, complition:((UIImage?) -> Void)?) -> Void {
        let identifire = imageUrl
        
        guard let request = request(apiName: imageUrl,
                                    policy: URLRequest.CachePolicy.returnCacheDataElseLoad)
            else { complition?(nil); return }
        
        guard let image = inMemoryCachedImage[identifire]
        else
        {
            self.task = service.send(request: request)
            {[weak self] (data:Data?, response: URLResponse?, error: Error?) in
                guard let strongSelf = self else { complition?(nil); return }
                if error == nil && data != nil{ //Success
                    strongSelf.handleSuccess(identifire: identifire, data: data!, response: response, complition: complition)
                } else { //Fail
                    strongSelf.handleFailure(error: error!, response: response, complition: complition)
                }
            }
            return
        }
        complition?(image)

    }
    
    private func handleSuccess(identifire: String,data: Data, response: URLResponse?, complition:((UIImage?) -> Void)?)
    {
        if let response = response as? HTTPURLResponse  {
            if isStatusSuccess(response: response) {
                let image = UIImage(data: data)
                inMemoryCachedImage[identifire] = image;
                DispatchQueue.main.async {
                    complition?(image)
                }
                return
            }
        }
        DispatchQueue.main.async {
            complition?(nil)
        }
    }
    
    //TODO: handle failure due to many region, For now sending nil image
    private func handleFailure(error: Error, response: URLResponse?, complition:((UIImage?) -> Void)?)
    {
        DispatchQueue.main.async {
            complition?(nil)
        }
    }
}
