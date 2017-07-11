//
//  RegisterViewController.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 06/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class RegisterViewController: LoginViewController
{
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad()
    {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    @IBAction func registerButton(_ sender: Any)
    {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        
        
        FirebaseLib.userRegister(account: email, password: password, username: password, name: "marcelo", age: "22")
        { 
            self.loginHandler(identifier: "RegisterToMainID")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    }
}
