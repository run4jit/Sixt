//
//  LoadingView.swift
//  Sixt
//
//  Created by Ranjeet on 26/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

let loadingViewTag = 456745343
class LoadingView: UIView {
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!

    @IBOutlet weak var loadingLabel: UILabel!
    
    class func instanceFromNib() -> LoadingView {
        return UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: self, options: nil).first as! LoadingView
    }
    
    func show(loadingText: String = NSLocalizedString("loading", comment: "loading"),
              onView view: UIView) -> Void {
        loadingLabel.text = loadingText
        spinnerView.startAnimating()
        
        if let loadingView = view.viewWithTag(loadingViewTag) {
            view.bringSubview(toFront: loadingView)
        } else {
            addView(subView: self, toParent: view)
        }
     }
    
    func hide() -> Void {
        spinnerView.stopAnimating()
        self.removeFromSuperview();
    }
}
