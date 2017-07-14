//
//  PhotoDestination.swift
//  BattleFace
//
//  Created by Marcelo Martimiano Junior on 14/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class PhotoDestinationViewController: UIViewController
{
    
    @IBOutlet weak var photoTaked: UIImageView!
    var photo = UIImage()

    @IBAction func postButton(_ sender: Any)
    {
        
    }
    @IBAction func cancelButton(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buildBattle(_ sender: Any)
    {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoTaked.image = photo
        
        
    }
}
