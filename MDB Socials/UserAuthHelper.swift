//
//  UserAuthHelper.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserAuthHelper {
    
    static func logIn(email: String, password: String, withBlock: @escaping ()->(), withBlock2: @escaping ()->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                print("log in successful")
                withBlock()
            } else {
                withBlock2()
            }
        })
    }

    static func logOut(withBlock: @escaping ()->()) {
        print("logging out")
        //TODO: Log out using Firebase!
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            withBlock()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    static func createUser(email: String, password: String, withBlock: @escaping (String) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                withBlock((user?.uid)!)
            }
            else {
                print(error.debugDescription)
            }
        })
    }

}
