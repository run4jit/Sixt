
//
//  CarMapViewModel.swift
//  Sixt
//
//  Created by test on 2/24/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit
import MapKit

protocol CarMapViewModelProtocol {
    func addMarker(carListViewModel: CarMapViewModel) -> Void
    func markerDidTapped(carListViewModel: CarMapViewModel, car: Car) -> Void 
}

class CarMapViewModel: NSObject, MKMapViewDelegate {
    var cars = [Car]()
    typealias AnnotationDidTapped = ((Car) -> Void)
    var annotationDidTapped:AnnotationDidTapped?
    var delegate: CarMapViewModelProtocol?
    
    func featchCarInfo() {
        CarManager.manager.getCarList(cached: true) {[weak self] (cars) in
            guard let strongSelf = self else { return }
            strongSelf.cars = cars
            strongSelf.delegate?.addMarker(carListViewModel: strongSelf)
        }
    }
    
    
    //MARK: - Map view delegate
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
        {
            if let annotation = annotation as? CarAnnotation {
                let identifier = "CarMarkerIdentifier"
                var view: MKAnnotationView?
                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
                }
                else
                {
                    view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                    view?.canShowCallout = true
                    view?.calloutOffset = CGPoint(x: -5, y: 5)
                    view?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                }
                view?.image = UIImage(named: "canMarkerIcon")
                return view
            }
            return nil
    }

    public func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        if let annotation = view.annotation as? CarAnnotation
        {
            self.delegate?.markerDidTapped(carListViewModel: self, car: annotation.car)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

    }
}
