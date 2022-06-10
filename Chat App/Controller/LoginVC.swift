//
//  LoginVC.swift
//  Chat App
//
//  Created by HAMZA on 30/5/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginVC: UIViewController {
    
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginClicked(_ sender: UIButton) {
        
        guard let email = emailTxtField.text,
              let password = passwordTxtField.text else {
            simpleAlert(title: "Error", msg: "Please fill out all fields.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                debugPrint(e.localizedDescription)
                Auth.auth().handleFireAuthError(error: e, vc: self)
                return
            } else {
                self.performSegue(withIdentifier: Segues.loginSegue, sender: self)
            }
        }
        
    }
}
