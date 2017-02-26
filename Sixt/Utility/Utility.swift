//
//  Utility.swift
//  Sixt
//
//  Created by test on 2/23/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import Foundation
import UIKit
typealias carListCallBack = (([Car]) -> Void)

protocol Serialize {
    static func serializer(json: AnyObject) -> AnyObject?
}

extension NSObject {
    var name: String {
        return String(describing: type(of: self))
    }
}

extension String {
    var storyboard: UIStoryboard {
        return UIStoryboard(name: self, bundle: Bundle.main)
    }
}


func storyboard(name: String) -> UIStoryboard {
    let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
    return storyboard
}

// Class name should match with xib/storyboard Identifire
func loadFromStoryboard(vcName: String) -> UIViewController {
    // Load Storyboard
    let mainStoryboard = "Main".storyboard
    
    // Instantiate View Controller
    let viewController = mainStoryboard.instantiateViewController(withIdentifier: vcName)
    return viewController
}

func add(childViewController child: UIViewController, to mainViewController: UIViewController) -> Void {
    let childViewController = loadFromStoryboard(vcName: child.name)
    // Add Child View Controller
    mainViewController.addChildViewController(childViewController)
    
    // Add Child View as Subview
    mainViewController.view.addSubview(childViewController.view)
    
    // Configure Child View
    childViewController.view.frame = mainViewController.view.bounds
    childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
    // Notify Child View Controller
    childViewController.didMove(toParentViewController: mainViewController)
}


func remove(viewController: UIViewController) -> Void {
    // Notify Child View Controller
    viewController.willMove(toParentViewController: nil)
    
    // Remove Child View From Superview
    viewController.view.removeFromSuperview()
    
    // Notify Child View Controller
    viewController.removeFromParentViewController()
}

// add subview and constraint to make it in full view
func addView(subView: UIView, toParent view: UIView) -> Void {
    view.addSubview(subView)
    subView.translatesAutoresizingMaskIntoConstraints = false
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["subview": subView]))
    view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics: nil, views: ["subview": subView]))
}
