////
//  ProfileViewController.swift
//  SnapchatCamera
//
//  Created by Clara Carneiro on 7/6/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

    
    @IBAction func logOutAction(_ sender: Any) {
        let defautls = UserDefaults.standard
        
        defautls.set("not logged", forKey: "login")
        print("realizou log Out")
        // voltar pra tela de login
        self.performSegue(withIdentifier: "ToLoginScreenID", sender: self)
        
    }

}
