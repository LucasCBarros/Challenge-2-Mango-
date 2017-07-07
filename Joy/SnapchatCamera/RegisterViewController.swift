//
//  RegisterViewController.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 06/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad()
    {
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.emailTextField.clearsOnBeginEditing = true
        self.passwordTextField.clearsOnBeginEditing = true
    }
    
    @IBAction func registerButton(_ sender: Any)
    {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        // valida dados
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil
            {
                // Troca de tela
                print("register ok")
            }
            else
            {
                // Trata erro
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func loginHandler()
    {
        let defautls = UserDefaults.standard
        
        defautls.set("logged", forKey: "login")
        print("salvou o login")
    }
}
