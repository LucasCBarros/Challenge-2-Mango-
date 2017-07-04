//
//  LoginScreenViewController.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 04/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit
import FirebaseDatabase

class LoginScreenViewController: UIViewController
{
    var ref: DatabaseReference?
    
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
    }
    
    @IBAction func registerButton(_ sender: Any)
    {
        if let text = self.userTextField.text
        {
            self.ref?.child("users").childByAutoId().setValue(text)
            
        }
    }
}
