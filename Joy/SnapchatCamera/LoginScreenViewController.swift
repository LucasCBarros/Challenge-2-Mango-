//
//  LoginScreenViewController.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 04/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginScreenViewController: UIViewController, UITextFieldDelegate
{
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //set delegate to textfile
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        self.emailTextField.clearsOnBeginEditing = true
        self.passwordTextField.clearsOnBeginEditing = true
    }
    
    @IBAction func logInButton(_ sender: Any)
    {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!
        // Fazer funcao que valida valores e retorna string
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let usr = user
            {
                print("logou")
                self.loginHandler()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        print("return")
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    
    func loginHandler()
    {
        let defautls = UserDefaults.standard
        
        defautls.set("logged", forKey: "login")
        print("salvou o login")
        
        self.performSegue(withIdentifier: "Main", sender: self)
    }
    
}
