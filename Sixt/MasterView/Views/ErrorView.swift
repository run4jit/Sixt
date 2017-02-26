//
//  ErrorView.swift
//  Sixt
//
//  Created by Ranjeet on 26/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

let errorViewTag = 18762343

class ErrorView: UIView {

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var errorImageView: UIImageView!
    
    class func instanceFromNib() -> ErrorView {
        return UINib(nibName: "ErrorView", bundle: nil).instantiate(withOwner: self, options: nil).first as! ErrorView
    }
    
    func show(errorMessage: String = NSLocalizedString("data_not_found", comment: "data not found"),
              onView view: UIView) -> Void {
        self.errorMessageLabel.text = errorMessage

        if let errorView = view.viewWithTag(errorViewTag) {
            view.bringSubview(toFront: errorView)
        } else {
            addView(subView: self, toParent: view)
        }
    }
    
    func hide() -> Void {
        self.removeFromSuperview();
    }

}
