//
//  RegisterVC.swift
//  Chat App
//
//  Created by HAMZA on 30/5/2022.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var confirmPassTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registreClicked(_ sender: UIButton) {
        
        
        guard let email = emailTxtField.text, !email.isEmpty,
              let password = passwordTxtField.text, !password.isEmpty else {
                  simpleAlert(title: "Error", msg: "Please fill out all fields")
                  return
              }
        
        guard let confirmPass = confirmPassTxtField.text , confirmPass == password else {
            simpleAlert(title: "Error", msg: "Passwords do not match.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                debugPrint(e)
                Auth.auth().handleFireAuthError(error: e, vc: self)
            } else {
                self.performSegue(withIdentifier: Segues.registerSegue, sender: self)
            }
        }
    }
    
    
    
}
