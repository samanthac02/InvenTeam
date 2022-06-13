//
//  DataViewController.swift
//  Inventeam App
//
//  Created by Samantha Chang on 9/21/21.
//

import UIKit
import AudioToolbox

class DataViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var BPMLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
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
                    self.BPMLabel.text = contents + "BPM"

                print(contents)

                    if Int(contents) ?? 0 > 90 {
                        self.statusLabel.text = "Drowning"
                        self.statusLabel.textColor = UIColor(red: 240/255, green: 113/255, blue: 104/255, alpha: 1.0)
                        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
                    } else {
                        self.statusLabel.text = "Swimming"
                    }
                } catch {}
            }
        })
    }
    
    @IBAction func stopTimer(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func hiddenButton(_ sender: Any) {
        if statusLabel.text! == "Swimming" {
            self.statusLabel.text = "Drowning"
            self.statusLabel.textColor = UIColor(red: 240/255, green: 113/255, blue: 104/255, alpha: 1.0)
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
        } else {
            self.statusLabel.text = "Swimming"
            self.statusLabel.textColor = UIColor.black
        }
    }
}
