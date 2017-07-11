//
//  PublicBattleViewController.swift
//  SnapchatCamera
//
//  Created by Clara Carneiro on 7/6/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import UIKit

class PublicBattlesViewController: UIViewController
{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBAction func loadImage(_ sender: Any)
    {
        self.activityIndicator.startAnimating()
        
        FirebaseLib.downloadImage(reference: "userImages/marcelove123/image2.jpg") { (image) in
            self.image.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func teste(_ sender: Any) {
        FirebaseLib.getUserInfo(userID: "marco@gmail.com")
    }
    override func didReceiveMemoryWarning() {
        
        print("Faltou memoria")
    }
}
