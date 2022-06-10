//
//  FeaturesViewController.swift
//  Inventeam App
//
//  Created by Samantha Chang on 9/23/21.
//

import UIKit

class FeaturesViewController: UIViewController {

    @IBOutlet weak var inventionImage: UIImageView!
    @IBOutlet weak var flotationDeviceImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        inventionImage.clipsToBounds = true
        inventionImage.layer.cornerRadius = 16
        inventionImage.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        flotationDeviceImage.clipsToBounds = true
    }

    @IBAction func buyButton(_ sender: Any) {
        guard let url = URL(string: "https://www.gofundme.com") else { return }
        UIApplication.shared.open(url)
    }
}
