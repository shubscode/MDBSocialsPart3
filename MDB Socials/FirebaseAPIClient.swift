//
//  FirebaseAPIClient.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import Foundation

import Firebase
import FirebaseDatabase

class FirebaseAPIClient {
    static func fetchPosts(withBlock: @escaping ([Post]) -> ()) {
        //TODO: Implement a method to fetch posts with Firebase!
        let ref = Database.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            withBlock([post])
        })
    }
    
//    static func fetchUser(id: String, withBlock: @escaping (User) -> ()) {
//        let ref = Database.database().reference()
//        ref.child("Users").child(id).observeSingleEvent(of: .value, with: { (snapshot) in
//            let user = User(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
//            withBlock(user)
//
//        })
//    }
    
    static func createNewPost(postDict: [String: Any]?) {
        let postsRef = Database.database().reference().child("Posts")
//        let newPost = ["text": postText, "poster": poster, "imageUrl": imageUrl, "posterId": posterId] as [String : Any]
        let key = postsRef.childByAutoId().key
        let childUpdates = ["/\(key)/": postDict]
        postsRef.updateChildValues(childUpdates)
    }
    
    static func createNewUser(id: String, name: String, email: String) {
        
        let usersRef = Database.database().reference().child("Users")
        let newUser = ["name": name, "email": email]
        let childUpdates = ["/\(id)/": newUser]
        usersRef.updateChildValues(childUpdates)
    }
}
