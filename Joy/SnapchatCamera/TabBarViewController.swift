//
//  TabBarViewController.swift
//  SnapchatCamera
//
//  Created by Clara Carneiro on 7/10/17.
//  Copyright © 2017 Archetapp. All rights reserved.
//

import UIKit

// global variables of icons
var icons = UIScrollView()
var corner = UIImageView()
var dot = UIView()


class TabBarViewController: UITabBarController {

    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // color of item
        self.tabBar.tintColor = UIColor(red: 25.0 / 255.0, green: 194.0 / 255.0, blue: 134.0 / 255.0, alpha: 1)
        
        self.tabBar.backgroundImage = UIImage(named: "TabBar.png")
        
        // color of background
//        self.tabBar.barTintColor = UIColor(red: 25.0 / 255.0, green: 194.0 / 255.0, blue: 134.0 / 255.0, alpha: 1)
        
        // disable translucent
        self.tabBar.isTranslucent = false
        
        // create total icons
        icons.frame = CGRect(x: self.view.frame.size.width / 5 * 3 + 10, y: self.view.frame.size.height - self.tabBar.frame.size.height * 2 - 3, width: 50, height: 35)
        self.view.addSubview(icons)
        

        
    }

    
    
    // multiple icons
    func placeIcon (_ image:UIImage, text:String) {
        
        // create separate icon
        let view = UIImageView(frame: CGRect(x: icons.contentSize.width, y: 0, width: 50, height: 35))
        view.image = image
        icons.addSubview(view)
        
        // create label
        let label = UILabel(frame: CGRect(x: view.frame.size.width / 2, y: 0, width: view.frame.size.width / 2, height: view.frame.size.height))
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        view.addSubview(label)
        
        // update icons view frame
        icons.frame.size.width = icons.frame.size.width + view.frame.size.width - 4
        icons.contentSize.width = icons.contentSize.width + view.frame.size.width - 4
        icons.center.x = self.view.frame.size.width / 5 * 4 - (self.view.frame.size.width / 5) / 4
        
        // unhide elements
        corner.isHidden = false
        dot.isHidden = false
    }
    
    
    // clicked upload button (go to upload)
    func upload(_ sender : UIButton) {
        self.selectedIndex = 2
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
