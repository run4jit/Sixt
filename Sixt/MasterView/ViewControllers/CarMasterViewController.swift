//
//  CarMasterViewController.swift
//  Sixt
//
//  Created by test on 2/23/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

class CarMasterViewController: UIViewController {

    @IBOutlet weak var segmentedView: UISegmentedControl!
    
    private lazy var carListViewController: CarListViewController = {
        var viewController = loadFromStoryboard(vcName: "CarListViewController") as! CarListViewController
        // Add View Controller as Child View Controller
        add(childViewController: viewController, to: self)
        
        return viewController
    }()

    private lazy var carMapViewController: CarMapViewController = {
        var viewController = loadFromStoryboard(vcName: "CarMapViewController") as! CarMapViewController
        // Add View Controller as Child View Controller
        add(childViewController: viewController, to: self)
        
        return viewController
    }()
    
    //Mark: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func updateView() {
        if segmentedView.selectedSegmentIndex == 0 {
            self.addChildViewController(carListViewController,
                                        andRemoveOld: carMapViewController)
        } else {
            self.addChildViewController(carMapViewController,
                            andRemoveOld: carListViewController)
        }
    }
    private func addChildViewController(_ childController: UIViewController, andRemoveOld oldViewController: UIViewController) {
        remove(viewController: oldViewController)
        add(childViewController: childController, to: self)
    }
    
    @IBAction func selectionDidChange(_ sender: UISegmentedControl) {
        updateView();
    }
    
}
