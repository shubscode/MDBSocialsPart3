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
import FirebaseStorage
import ObjectMapper
import PromiseKit

class Users : Mappable {
    
    var name: String?
    var email: String?
    var profilePicture: UIImage?
    var username: String?
    var profilePictureURL: String?
    var id: String?
    var myEventsArray = [String]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id                  <- map["userID"]
        name                <- map["name"]
        username            <- map["username"]
        profilePictureURL   <- map["profilePictureURL"]
        email               <- map["email"]
        myEventsArray       <- map["myEventsArray"]
    }
    
    func getPicture() -> Promise<UIImage> {
        return Promise { fulfill, _ in
            let urlReference = Storage.storage().reference(forURL: profilePictureURL!)
            urlReference.getData(maxSize: 30 * 1024 * 1024) { data, error in
                if let error = error {
                    print("Error getting image")
                    print(error.localizedDescription)
                } else {
                    let image = UIImage(data: data!)!
                    fulfill(image)
                }
            }
        }
    }
    
    

    
//    static func getCurrentUser(withId: String, block: @escaping (User) -> ()) {
//        FirebaseAPIClient.fetchPosts(id: withId, withBlock: {(user) in
//            block(user)
//        })
//    }
    
    
}
