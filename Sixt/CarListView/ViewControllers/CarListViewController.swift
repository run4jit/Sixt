//
//  CarListViewController.swift
//  Sixt
//
//  Created by test on 2/23/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

class CarListViewController: ViewController, CarListViewModelProtocol {
    @IBOutlet weak var tableView: UITableView!
    private let carListViewModel = CarListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        inMemoryCachedImage.removeAll();// clear all car images
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {

        let nib = UINib(nibName: "CarTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "CarTableViewCell")
        
        self.carListViewModel.carListViewModelProtocol = self
        self.tableView.delegate = self.carListViewModel
        self.tableView.dataSource = self.carListViewModel
        self.loadingView.show(onView: self.view)
        self.carListViewModel.featchCarInfo();
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func carCellDidTapped(carListViewModel: CarListViewModel, car: Car) -> Void
    {
        if let detailVC = loadFromStoryboard(vcName: "CarDetailViewController") as? CarDetailViewController
        {
            detailVC.car = car;
            detailVC.title = car.ownerName
            show(detailVC, sender: nil)
        }
    }
    
    func updateCarTableView(carListViewModel: CarListViewModel) -> Void
    {
        DispatchQueue.main.async {
            self.loadingView.hide()
            if carListViewModel.totalCarCount <= 0 {
                self.errorView.show(onView: self.view)
            } else {
                self.errorView.hide()
                self.tableView.reloadData()
            }
        }
    }

    
}
