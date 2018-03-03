//
//  Post.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage


class Post {
    var eventDescription: String?
    var eventDate: String?
    var eventName: String?
    var posterName: String?
    var id: String?
    var interested = [String]()
    var image : UIImage?
    init(id: String, postDict: [String:Any]?) {
        self.id = id
        if let text = postDict!["text"] as? String {
            self.eventDescription = text
        }
        if let date = postDict!["date"] as? String {
            self.eventDate = date
        }
        if let name = postDict!["name"] as? String {
            self.eventName = name
        }
        if let poster = postDict!["poster"] as? String {
            self.posterName = poster
        }
        if let interested = postDict!["interested"] as? [String] {
            self.interested = interested
        }
    }
    
    func getProfilePic(withBlock: @escaping () -> ()){
        //print(self.name)
        let ref = Storage.storage().reference().child("/Posts/\(id!)")
        ref.getData(maxSize: 1 * 2048 * 2048) { (data, error) in
            if error != nil {
            } else {
                self.image = UIImage(data: data!)
            }
            withBlock()
        }
    }    }
    
//    init() {
//        self.text = "This is a god dream"
//        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
//        self.id = "1"
//        self.poster = "Kanye West"
//    }
    
//    func getProfilePic(withBlock: @escaping () -> ()) {
//        //TODO: Get User's profile picture
//        //let ref = FIRStorage.storage().reference().child("/profilepics/\(posterId!)")
//        ref.data(withMaxSize: 1 * 2048 * 2048) { data, error in
//            if let error = error {
//                print(error)
//            } else {
//                self.image = UIImage(data: data!)
//                withBlock()
//            }
//        }
//    }

