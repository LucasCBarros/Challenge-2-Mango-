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
    static func storePhoto(reference: String, photoData: Data)
    {
//        // Reference for database
//        var databaseRef: DatabaseReference!
//        databaseRef = Database.database().reference()
//        
//        // Get a reference to the storage service using the default Firebase App
//        let storage = Storage.storage()
//        
//        // Create a storage reference from our storage service
//        let storageRef = storage.reference()
//        
//        
//        
//        let userImages = storageRef.child("userImages")
//        let user = "marcelove123/"
//        let imageName = "image" + "\(photoNum)" + ".jpg"
//        //photoNum += 1
//        
//        
//        let imageRef = userImages.child(user + imageName)
//        
//        print("vai tentar subir")
//        // Upload the file to the path
//        let uploadTask = imageRef.putData(photoData, metadata: nil)
//        { (metadata, error) in
//            guard let metadata = metadata else
//            {
//                print("Erro")
//                // Uh-oh, an error occurred!
//                return
//            }
//            // Metadata contains file metadata such as size, content-type, and download URL.
//            let downloadURL = metadata.downloadURL
//            print(downloadURL)
//        }
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
        imageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
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
    static func getData(reference: String) ->String
    {
        return " "
    }
    
//    static func setData(reference: String, data: String)
//    {
//        var ref: DatabaseReference!
//        ref = Database.database().reference()
//           self.ref.child("Usuarios").childByAutoId().setValue(data)
//    }
    
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
    
enum UserData
{
    case email, name, age
}
    static func getUserInfo(userID: String) ->[String]
    {
        var userInfo = [String]()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()

        ref.child("userData").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //let value = snapshot.value as? NSDictionary
            //let username = value?["userID"] as? String ?? ""
            //let user = User.init(username: username)
            
            //print("value:\(value)")
          //  print("username:\(username)")
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return userInfo
    }
}
