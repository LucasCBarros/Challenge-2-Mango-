////
//  ProfileViewController.swift
//  SnapchatCamera
//
//  Created by Clara Carneiro on 7/6/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase

class ProfileViewController: UIViewController, UICollectionViewDataSource
{
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var photoCollection: UICollectionView!
    
    var images = [UIImage]() //////
    
//    var images = [ProfileImages]()
    var customImageFlowLayout: CustomImageFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Log.getUser()
        {
            self.username.text = user
        }
        loadImages()
        customImageFlowLayout = CustomImageFlowLayout()
        photoCollection.collectionViewLayout = customImageFlowLayout
        photoCollection.backgroundColor = .white
    }
    
    func loadImages()
    {
        print("load imagens")
        if let user = Log.getUser()
        {
            print("achou user")
            FirebaseLib.getProfilePhoto(user: user)
            { (photo) in
                self.images.append(photo)
            }
            self.photoCollection.reloadData()
        }
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        loadImages()
    }
    
    @IBAction func logOutAction(_ sender: Any)
    {
        let defautls = UserDefaults.standard
        
        defautls.set("", forKey: "username")
        print("realizou log Out")
        // voltar pra tela de login
        self.performSegue(withIdentifier: "ToLoginScreenID", sender: self)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ imageCollection: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let image = images[indexPath.row]
        
        cell.imageView.image = image;
        
        return cell
    }
}
