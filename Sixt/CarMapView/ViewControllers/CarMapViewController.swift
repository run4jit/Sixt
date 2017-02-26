//
//  CarMapViewController.swift
//  Sixt
//
//  Created by test on 2/23/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit
import MapKit


class CarMapViewController: ViewController, CarMapViewModelProtocol {
    @IBOutlet weak var mapView: MKMapView!
    private var carMapViewModel = CarMapViewModel()
    let regionRadius: CLLocationDistance = 1000
    let initialLocation = CLLocation(latitude: 48.149, longitude: 11.580)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setupView() -> Void {
        self.loadingView.show(onView: self.view)

        self.carMapViewModel.delegate = self
        self.mapView.delegate = self.carMapViewModel
        centerMapOnLocation(location: initialLocation)
        self.carMapViewModel.featchCarInfo()
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 5.0, regionRadius * 5.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    //MARK: - CarMapViewModelProtocol
    func addMarker(carListViewModel: CarMapViewModel) {
        DispatchQueue.main.async {
            self.loadingView.hide()
            self.removeMarker()

            if self.carMapViewModel.cars.count <= 0 {
                self.errorView.show(onView: self.view)
            } else {
                self.errorView.hide()
                for car in self.carMapViewModel.cars {
                    self.mapView.addAnnotation(CarAnnotation(car: car))
                }
            }

        }
    }
    
    func removeMarker() {
        for annotation  in mapView.annotations {
            if annotation is MKUserLocation {
                continue
            }
            self.mapView.removeAnnotation(annotation)
        }
        
    }
    func markerDidTapped(carListViewModel: CarMapViewModel, car: Car) -> Void
    {
        if let detailVC = loadFromStoryboard(vcName: "CarDetailViewController") as? CarDetailViewController
        {
            detailVC.car = car;
            detailVC.title = car.ownerName
            show(detailVC, sender: nil)
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
