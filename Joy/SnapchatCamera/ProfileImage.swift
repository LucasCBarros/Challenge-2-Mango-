//
//  ProfileImage.swift
//  SnapchatCamera
//
//  Created by Lucas Barros on 10/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct ProfileImages {
    let key:String!
    let url:String!
    
//    let itemRef: FIRDatabaseReference?
    
    init(url:String, key:String){
        self.key = key
        self.url = url
        
//        self.itemRef = nil
    }
    
//    init (snapshot:FIRDatabaseReference){
//        key = snapshot.key
//        itemRef = snapshot.ref
//        
//        let snapshotValue = snapshot.value as? NSDictionary
//        
//        if let imageUrl = snapshotValue?["url"] as? String{
//            url = imageUrl
//        } else {
//            url = ""
//        }
//    }
}

