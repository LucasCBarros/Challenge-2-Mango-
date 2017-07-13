////
//  ProfileViewController.swift
//  SnapchatCamera
//
//  Created by Clara Carneiro on 7/6/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource
{
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var profilePhotoView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoCollection: UICollectionView!
    var username: String?
    
    var images = [UIImage]() //////
    
//    var images = [ProfileImages]()
    var customImageFlowLayout: CustomImageFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setProfilePhoto()
        
//        if let userID = Log.getUserID()
//        {
//            //self.username = FirebaseLib.getUsernameFromUserID(userID: userID, completionHandler: (String) -> Void)
////            usernameLabel.text = self.username
//        }
//        
//        loadImages()
        customImageFlowLayout = CustomImageFlowLayout()
        photoCollection.collectionViewLayout = customImageFlowLayout
        photoCollection.backgroundColor = .white
    }
    
    func loadImages()
    {
        print("load imagens")
//        if let user = Log.getUser()
//        {
//            print("achou user")
//            FirebaseLib.getProfilePhoto(user: user)
//            { (photo) in
//                self.images.append(photo)
//            }
            self.photoCollection.reloadData()
//        }
    }
    func setProfilePhoto()
    {
        // Configuration of UImageView
        self.profilePhotoView.layer.cornerRadius = self.profilePhotoView.frame.size.width / 2
        self.profilePhotoView.layer.masksToBounds = true
        
        self.activityIndicator.startAnimating()
        
        let userID = Log.getUserID()
        FirebaseLib.getUsernameFromUserID(userID: userID!, completionHandler:
            { (username) in
                
                if username != nil
                {
                    FirebaseLib.getProfilePhoto(user: username!, completionHandler:
                        { (photo) in
                            self.profilePhotoView.image = photo
                            self.activityIndicator.stopAnimating()
                    })
                }
        })
    }
    @IBAction func reloadAction(_ sender: Any) {
        loadImages()
    }
    
    @IBAction func logOutAction(_ sender: Any)
    {
        Log.logOut()
        print("realizou log Out")
        // voltar pra tela de login
        self.performSegue(withIdentifier: "ToLoginScreenID", sender: self)

    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
//
    func collectionView(_ imageCollection: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let image = images[indexPath.row]
        
        cell.imageView.image = image;
        
        return cell
    }
}
