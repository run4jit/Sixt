//
//  CarDetailViewController.swift
//  Sixt
//
//  Created by test on 2/23/17.
//  Copyright © 2017 Ranjeet. All rights reserved.
//

import UIKit

class CarDetailViewController: ViewController {

    var car: Car? = nil

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameValueLabel: UILabel!
    
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var modelLabelValue: UILabel!

    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var groupLabelValue: UILabel!
    
    @IBOutlet weak var fuleTypeLabel: UILabel!
    @IBOutlet weak var fuleTypeValueLabel: UILabel!
    
    @IBOutlet weak var fuleLevelLabel: UILabel!
    @IBOutlet weak var fuleLevelSlider: UISlider!
    
    @IBOutlet weak var transmissionLabel: UILabel!
    @IBOutlet weak var transmissionValueLabel: UILabel!
    
    @IBOutlet weak var licenceLabel: UILabel!
    @IBOutlet weak var licenceValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(car?.ownerName)");
        setupView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        self.nameLabel.text = NSLocalizedString("name", comment: "Name");
        self.nameValueLabel.text = car?.ownerName

        self.modelLabel.text = NSLocalizedString("model", comment: "Model");
        self.modelLabelValue.text = car?.model

        self.groupLabel.text = NSLocalizedString("group", comment: "Group");
        self.groupLabelValue.text = car?.carGroup

        self.fuleTypeLabel.text = NSLocalizedString("fuel_type", comment: "Fuel Type");
        self.fuleTypeValueLabel.text = car?.fuel

        self.fuleLevelLabel.text = NSLocalizedString("fuel_level", comment: "Fuel Level");
        self.fuleLevelSlider.value = car?.carFuelLevel ?? 0

        self.transmissionLabel.text = NSLocalizedString("transmission", comment: "Transmission");
        self.transmissionValueLabel.text = car?.transmission

        self.licenceLabel.text = NSLocalizedString("licence", comment: "Licence");
        self.licenceValueLabel.text = car?.numberPlate
        
        CarManager
            .manager
            .getCarImage(url: (car?.imageUrl)!,
                         complition: {[weak self] (image) in
                                        guard let strongSelf = self, let img = image else {return}
                                  strongSelf.imageView.image = img
        })
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
