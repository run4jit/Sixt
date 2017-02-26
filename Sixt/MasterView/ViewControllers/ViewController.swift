//
//  ViewController.swift
//  Sixt
//
//  Created by Ranjeet on 26/02/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var errorView: ErrorView = {
        return ErrorView.instanceFromNib()
    }()
    
    lazy var loadingView: LoadingView = {
        return LoadingView.instanceFromNib()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

}
