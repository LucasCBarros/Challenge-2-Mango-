//
//  Challenge.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 09/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit
import FirebaseStorage

class Challenge
{
    static var photoNum = 0
    
    static func storePhoto(photoData: Data)
    {
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        let userImages = storageRef.child("UserImages")
        let user = "marcelove123/"
        let imageName = "image" + "\(photoNum)" + ".jpg"
        photoNum += 1
        
        
        let imageRef = userImages.child(user + imageName)
        
        print("vai tentar subir")
        // Upload the file to the path
        let uploadTask = imageRef.putData(photoData, metadata: nil)
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
    
    static func downloadImage() -> UIImage
    {
        var image: UIImage?
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Create a reference with an initial file path and name
        //let pathReference = storage.reference(withPath: "images/stars.jpg")
        
        // Create a reference to the file you want to download
        let islandRef = storageRef.child("UserImages/marcelove123/image2.jpg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("deu erro")
                image = nil
            } else {
                // Data for "images/island.jpg" is returned
//                //let tryImage = UIImage(data: data)
//                {
//                    //image = tryImage
//                }
            }
        }
        
        return image!
    }
}
