//
//  Log.swift
//  SnapchatCamera
//
//  Created by Marcelo Martimiano Junior on 12/07/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

class Log
{
    static func getUser() -> String?
    {
        var username: String?
        let defautls = UserDefaults.standard
        if let user = defautls.string(forKey: "username")
        {
            username = user
        }
        return username
    }
}
