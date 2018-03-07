//
//  TabBarController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 3/6/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let item1 = UIBarButtonItem(title: "Add New Event", style: .plain, target: self, action: #selector(createNewEvent))
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
                //setUpCollectionView()
        
        let item2 = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutUser))
        self.navigationItem.setLeftBarButtonItems([item2], animated: true)
    }

    @objc func createNewEvent() {
        self.performSegue(withIdentifier: "toNewSocial", sender: self)
    }
    
    @objc func logoutUser() {
        UserAuthHelper.logOut().then {success -> Void in
            self.performSegue(withIdentifier: "backToSignIn", sender: self)
        }
        
    }


}
