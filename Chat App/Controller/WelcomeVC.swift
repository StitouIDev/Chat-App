//
//  ViewController.swift
//  Chat App
//
//  Created by HAMZA on 30/5/2022.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        let titleText = "⚡️Chat App⚡️"
        var charIndex = 0
        for title in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false) { timer in
                self.titleLabel.text?.append(title)
            }
            charIndex += 1
        }
    }


}

