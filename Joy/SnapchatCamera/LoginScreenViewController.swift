//
//  LoginScreenViewController.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 04/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class LoginScreenViewController: LoginViewController
{
    
    @IBOutlet var logoImg: UIImageView!
    // textfield
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    // buttons
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!

    
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        // alignment
//        logoImg.frame = CGRect(x: 10, y: 80, width: self.view.frame.size.width - 20, height: 50)
//        usernameTxt.frame = CGRect(x: 10, y: logoImg.frame.origin.y + 70, width: self.view.frame.size.width - 20, height: 30)
//        passwordTxt.frame = CGRect(x: 10, y: usernameTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
//        signInBtn.frame = CGRect(x: 20, y:  passwordTxt.frame.origin.y + 70, width: self.view.frame.size.width / 4, height: 30)
//        signInBtn.layer.cornerRadius = signInBtn.frame.size.width / 20
//        
//        signUpBtn.frame = CGRect(x: self.view.frame.size.width - self.view.frame.size.width / 4 - 20, y: signInBtn.frame.origin.y, width: self.view.frame.size.width / 4, height: 30)
//        signUpBtn.layer.cornerRadius = signUpBtn.frame.size.width / 20
        
        // tap to hide keyboard
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(LoginScreenViewController.hideKeyboard(_:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        // background
        let bg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        bg.image = UIImage(named: "background.jpg")
        bg.layer.zPosition = -1
        self.view.addSubview(bg)
    }
    
    
    // hide keyboard func
    func hideKeyboard(_ recognizer : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    // clicked sign in button
    @IBAction func signInBtn_click(_ sender: AnyObject) {
        print("sign in pressed")
        
        // hide keyboard
        self.view.endEditing(true)
        
        // if textfields are empty
        if usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty {
            
            // show alert message
            let alert = UIAlertController(title: "Please", message: "fill in fields", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        
        // login functions
        let email = self.usernameTxt.text!
        let password = self.passwordTxt.text!
        
        FirebaseLib.signIn(account: email, password: password)
        { (errorDescription) in
            
            if errorDescription == nil
            {
                self.loginHandler(segueIdentifier: "LoginScreenToMainID")
            }
            else
            {
                // show alert message
                let alert = UIAlertController(title: "Error", message: errorDescription!, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
        
}
