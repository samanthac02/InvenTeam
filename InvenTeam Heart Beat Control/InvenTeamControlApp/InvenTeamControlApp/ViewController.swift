//
//  ViewController.swift
//  InvenTeamControlApp
//
//  Created by Samantha Chang on 6/6/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var web: UIWebView!
    var currentState: String = "reset"
    var timer = Timer()
    var timeInterval = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
            print(self.currentState)
            
            let url = URL(string: "http://192.168.4.1/led/0")
            let urlreq=URLRequest(url: url!)
            self.web.loadRequest(urlreq)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (self.timeInterval - 0.1)) { // 0.5 seconds
                let url2 = URL(string: "http://192.168.4.1/led/1")
                let urlreq2 = URLRequest(url: url2!)
                self.web.loadRequest(urlreq2)
            }
        })
    }
    
    @IBAction func regularHeartButton(_ sender: Any) {
        currentState = "startHeart"
        timeInterval = 0.65
    }
    
    @IBAction func drowningHeartButton(_ sender: Any) {
        currentState = "startDrowning"
        timeInterval = 0.5
    }
    
    @IBAction func resetButton(_ sender: Any) {
        currentState = "reset"
        timer.invalidate()
    }
}

