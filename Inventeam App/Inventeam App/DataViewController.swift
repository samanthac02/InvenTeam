//
//  DataViewController.swift
//  Inventeam App
//
//  Created by Samantha Chang on 9/21/21.
//

import UIKit

class DataViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var BPMLabel: UILabel!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            let url = URL(string: "http://192.168.4.1/read")
            let urlreq=URLRequest(url: url!)
            self.webView.loadRequest(urlreq)
            
            if let url = URL(string: "http://192.168.4.1/read") {
                do {
                    var contents = try String(contentsOf: url)
                    contents = contents.replacingOccurrences(of: "<!DOCTYPE HTML>", with: "")
                    contents = contents.replacingOccurrences(of: "<html>", with: "")
                    contents = contents.replacingOccurrences(of: "\n", with: "")
                    contents = contents.replacingOccurrences(of: " ", with: "")
                    contents = contents.replacingOccurrences(of: "\r", with: "")
                    self.BPMLabel.text = contents
                    
                    print(contents)
                    
                    if Int(contents) ?? 0 > 100 {
                        print("JELLO")
                        self.BPMLabel.text = "UR KID IS DYING"
                    }
                } catch {
                    // contents could not be loaded
                }
            } else {
                // the URL was bad!
            }
        })
    }

}
