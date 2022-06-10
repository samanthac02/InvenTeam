//
//  AboutUsViewController.swift
//  Inventeam App
//
//  Created by Samantha Chang on 9/21/21.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buyButton(_ sender: Any) {
        guard let url = URL(string: "https://www.gofundme.com") else { return }
        UIApplication.shared.open(url)
    }
}
