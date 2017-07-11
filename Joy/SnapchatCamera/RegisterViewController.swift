//
//  RegisterViewController.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 06/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class RegisterViewController: LoginViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    // profile image
    @IBOutlet weak var avaImg: UIImageView!

    // textfields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var emailTxt: UITextField!

    // buttons
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!


    // scrollView
    @IBOutlet weak var scrollView: UIScrollView!

    // reset default size
    var scrollViewHeight : CGFloat = 0

    // keyboard frame size
    var keyboard = CGRect()


    // default func
    override func viewDidLoad() {
        super.viewDidLoad()

        // scrollview frame size
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollView.frame.size.height

        // check notifications if keyboard is shown or not
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.showKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.hideKeybard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        // declare hide kyboard tap
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.hideKeyboardTap(_:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)

        // round ava
        avaImg.layer.cornerRadius = avaImg.frame.size.width / 2
        avaImg.clipsToBounds = true

        // declare select image tap
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.loadImg(_:)))
        avaTap.numberOfTapsRequired = 1
        avaImg.isUserInteractionEnabled = true
        avaImg.addGestureRecognizer(avaTap)

        // alignment
        avaImg.frame = CGRect(x: self.view.frame.size.width / 2 - 40, y: 80, width: 160, height: 160)
        usernameTxt.frame = CGRect(x: 10, y: avaImg.frame.origin.y + 160, width: self.view.frame.size.width - 20, height: 30)
        emailTxt.frame = CGRect(x: 10, y: usernameTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        passwordTxt.frame = CGRect(x: 10, y: emailTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)
        repeatPassword.frame = CGRect(x: 10, y: passwordTxt.frame.origin.y + 40, width: self.view.frame.size.width - 20, height: 30)


        signUpBtn.frame = CGRect(x: 20, y: repeatPassword.frame.origin.y + 60, width: self.view.frame.size.width / 4, height: 30)
        signUpBtn.layer.cornerRadius = signUpBtn.frame.size.width / 20

        cancelBtn.frame = CGRect(x: self.view.frame.size.width - self.view.frame.size.width / 4 - 20, y: signUpBtn.frame.origin.y, width: self.view.frame.size.width / 4, height: 30)
        cancelBtn.layer.cornerRadius = cancelBtn.frame.size.width / 20

        // background
        let bg = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        bg.image = UIImage(named: "background.jpg")
        bg.layer.zPosition = -1
        self.view.addSubview(bg)
    }


    // call picker to select image
    func loadImg(_ recognizer:UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }


    // connect selected image to our ImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }


    // hide keyboard if tapped
    func hideKeyboardTap(_ recoginizer:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    

    // show keyboard
    func showKeyboard(_ notification:Notification) {

        // define keyboard size
        keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!

        // move up UI
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboard.height
        })
    }


    // hide keyboard func
    func hideKeybard(_ notification:Notification) {

        // move down UI
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.scrollView.frame.size.height = self.view.frame.height
        })
    }



    // clicked sign up
    @IBAction func signUpBtn_click(_ sender: AnyObject) {
        print("sign up pressed")

        // dismiss keyboard
        self.view.endEditing(true)

        // if fields are empty
        if (usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || repeatPassword.text!.isEmpty || emailTxt.text!.isEmpty) {

            // alert message
            let alert = UIAlertController(title: "PLEASE", message: "fill all fields", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)

            return
        }

        // if different passwords
        if passwordTxt.text != repeatPassword.text {

            // alert message
            let alert = UIAlertController(title: "PASSWORDS", message: "do not match", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)

            return
        }


        // send data to server to related collumns
        let email = self.emailTxt.text!
        let password = self.passwordTxt.text!

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil
            {
                // Troca de tela
                print("register ok")
                self.loginHandler(identifier: "RegisterToMainID")
            }
            else {

                // show alert message
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }

    /* @IBAction func registerButton(_ sender: Any)
    {
        let email = self.emailTextField.text!
        let password = self.passwordTextField.text!


        FirebaseLib.userRegister(account: email, password: password, username: password, name: "marcelo", age: "22")
        {
            self.loginHandler(identifier: "RegisterToMainID")
        } */
    }

    // clicked cancel
    @IBAction func cancelBtn_click(_ sender: AnyObject) {

        // hide keyboard when pressed cancel
        self.view.endEditing(true)

        self.dismiss(animated: true, completion: nil)
    }



}
