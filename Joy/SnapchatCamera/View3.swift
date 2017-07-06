//
//  AppDelegate.swift
//  JoyCamera
//
//  Created by Clara Carneiro on 7/28/17.
//  Copyright (c) 2017 Joy. All rights reserved.
//

import UIKit

class View3: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func logOutButton(_ sender: Any)
    {
        let defautls = UserDefaults.standard
        
        defautls.set("not logged", forKey: "login")
        print("realizou log Out")
        // voltar pra tela de login

    }
}
