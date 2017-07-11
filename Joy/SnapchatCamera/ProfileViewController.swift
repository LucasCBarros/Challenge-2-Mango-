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
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    var images = [UIImage]() //////
    
//    var images = [ProfileImages]()
    var customImageFlowLayout: CustomImageFlowLayout!
    
//    var dbRef: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dbRef = FIRdatabase.database().refence().child("images")
        
        loadImages()
        customImageFlowLayout = CustomImageFlowLayout()
        photoCollection.collectionViewLayout = customImageFlowLayout
        photoCollection.backgroundColor = .white
    }
    
    func loadImages(){

//        dbRef.observe(FIRDataEventType.value, width: { (snapshot) in
//            var newImages =  [ProfileImages]()
//            
//           for profileImagesSnapshot in snapshot.children {
//                let profileImagesObject = ProfileImages(snapshot: profileImagesSnapshot as! FIRDataSnapshot)
//            newImages.append(profileImagesObject)
//            }
//            self.images = newImages
//            self.photoCollection.reloadData()
//        })
        
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        images.append(UIImage(named: "image1")!)
        self.photoCollection.reloadData()
        
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        loadImages()
    }
    
    @IBAction func logOutAction(_ sender: Any)
    {
        let defautls = UserDefaults.standard
        
        defautls.set("not logged", forKey: "login")
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
