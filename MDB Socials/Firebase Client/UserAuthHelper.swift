//
//  UserAuthHelper.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import PromiseKit


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

//    static func logOut(withBlock: @escaping ()->()) {
//        print("logging out")
//        //TODO: Log out using Firebase!
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//            withBlock()
//        } catch let signOutError as NSError {
//            print ("Error signing out: %@", signOutError)
//        }
//    }
    static func logOut() -> Promise<Bool> {
        print("logging out")
        return Promise{fulfill, _ in
        
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                fulfill(true)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }

//    static func createUser(email: String, password: String, withBlock: @escaping (String) -> ()) {
//        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
//            if error == nil {
//                withBlock((user?.uid)!)
//            }
//            else {
//                print(error.debugDescription)
//            }
//        })
//    }
    
    static func createUser(name: String, username: String, email: String, password: String, image: UIImage, view: UIViewController, withBlock: @escaping (User) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
            if error == nil {
                FirebaseAPIClient.createNewUser(name: name, username: username, email: email, image: image).then{_ -> Void in
                    print("User created!")
                    withBlock(user!)
                    
                }
            }
            else {
                print(error.debugDescription)
                raiseAlert(title: "Sign Up Error", message: "Sorry there was an error creating your account. Try again later.", currentView: view)
            }
        })
        
    }
    
    static func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    static private func raiseAlert(title: String, message: String, currentView: UIViewController) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        currentView.present(alertController, animated: true, completion: nil)
    }


}
