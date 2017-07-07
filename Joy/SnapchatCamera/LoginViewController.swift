//
//  LoginViewController.swift
//  SnapchatCamera
//
//  Created by Clara Carneiro on 7/7/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate
{
    func loginHandler(identifier: String)
    {
        let defautls = UserDefaults.standard
        
        defautls.set("logged", forKey: "login")
        print("Realizou login")
        
        self.performSegue(withIdentifier: identifier, sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true
    }


    
}
