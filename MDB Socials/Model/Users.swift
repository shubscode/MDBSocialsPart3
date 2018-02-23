//
//  User.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class Users {
    var name: String?
    var email: String?
    
    var username: String?
    var password: String?
    //var imageUrl: String?
    var id: String?
    
    init(id: String, userDict: [String:Any]?) {
        self.id = id
        if userDict != nil {
            if let name = userDict!["name"] as? String {
                self.name = name
            }
            if let email = userDict!["email"] as? String {
                self.email = email
            }
            if let username = userDict!["username"] as? String {
                self.username = username
            }
            
        }
    }
    
//    static func getCurrentUser(withId: String, block: @escaping (User) -> ()) {
//        FirebaseAPIClient.fetchPosts(id: withId, withBlock: {(user) in
//            block(user)
//        })
//    }
    
    
}
