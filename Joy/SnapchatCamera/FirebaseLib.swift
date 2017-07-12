//
//  Challenge.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 09/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class FirebaseLib
{
    static func editProfilePhoto(user: String, photoData: Data)
    {
        var path = "userPhotos/" + user + "/profilePhoto.jpg"
        self.storePhoto(reference: path, photoData: photoData)
        
    }
    static func getProfilePhoto(user: String, completionHandler: @escaping (UIImage) -> Void)
    {
        let path = "userPhotos/" + user + "/profilePhoto.jpg"
        
        self.downloadImage(reference: path)
        {
            (profilePhoto) in
            
            DispatchQueue.main.async
            {
                completionHandler(profilePhoto)
            }
        }
        
    }
    static func storePhoto(reference: String, photoData: Data)
    {
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Create a reference as the path of image tha will be saved
        let imageRef = storageRef.child(reference)
        
        print("vai tentar subir")
        // Upload the file to the path
        imageRef.putData(photoData, metadata: nil)
        { (metadata, error) in
            guard let metadata = metadata else
            {
                print("Erro")
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL
            print(downloadURL)
        }
    }
    
    static func downloadImage(reference: String, completionHandler: @escaping (UIImage) -> Void)
    {

        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Create a reference with an initial file path and name
        //let pathReference = storage.reference(withPath: "images/stars.jpg")
        
        // Create a reference to the file you want to download
        let imageRef = storageRef.child(reference)
    
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 10 * 1024 * 1024) { data, error in
            if error != nil
            {
                // Uh-oh, an error occurred!
                print("deu erro")
            }
            else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)!
                
                DispatchQueue.main.async{
                    completionHandler(image)
                }
            }
        }
    
    }
    
    static func getUserFromEmail(email: String) -> String?
    {
        var username: String?
        var ref: DatabaseReference!
        ref = Database.database().reference()
//      
//        ref.child("usernames").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let keys = value?.allKeys as? [String]
//            
//            for index in 0..< value
//            {
//                username = value?["email"] as? String ?? ""
//            }
//            
//            
//            })
        username = " "
        return username
    }

    
    
    static func getUserData(user: String) ->UserData?
    {
        var userData: UserData?
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        
        print("vai obter dados")
        ref.child("usersData").child(user).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            let account = value?["account"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let age = value?["age"] as? String ?? ""
            let collectionPhotosPath = [String]()
            
            
            
            userData = UserData(username: user, account: account, name: name, age: age)
            
        }) { (error) in
            print(error.localizedDescription)
        }
        return userData
    }
    
    static func userRegister(account: String, password: String, username: String, name: String, age: String,
                             completionHandler: @escaping (String?) -> Void)
    {
        // verifica se a conta e o username já não existem!!!!!!!!!!!!!!!!!
        
        Auth.auth().createUser(withEmail: account, password: password) { (user, error) in
            if user != nil
            {
                print("register ok")
                DispatchQueue.main.async
                {
                    completionHandler(error?.localizedDescription)
                }
            }
            else
            {
                
                DispatchQueue.main.async
                    {
                        completionHandler(error?.localizedDescription)
                }
                
                print("Register error")
            }
        }
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
    

        let user =  ref.child("usersData").child(username)
        if user != nil
        {
            user.child("account").setValue(account)
            user.child("name").setValue(name)
            user.child("age").setValue(age)
        }
    }
}
