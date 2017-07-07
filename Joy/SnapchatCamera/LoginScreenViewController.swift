//
//  LoginScreenViewController.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 04/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginScreenViewController: LoginViewController
{
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set delegate to textfile
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    @IBAction func logInButton(_ sender: Any)
    {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        // Fazer funcao que valida valores e retorna string
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let usr = user
            {
                self.loginHandler(identifier: "LoginScreenToMainID")
            }
            else
            {
                print("erro no login sem registro")
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
        
}
