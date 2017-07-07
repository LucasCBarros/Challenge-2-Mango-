//
//  SegueToCameraView.swift
//  SnapchatCamera
//
//  Created by Clara Carneiro on 7/6/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import UIKit

class SegueToCameraView: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        performSegue(withIdentifier: "CameraSegue", sender: AnyObject.self)
    }
    
}
