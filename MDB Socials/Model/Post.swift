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
import ObjectMapper
import Haneke
import PromiseKit

class Post: Mappable {
    
    var eventDate: String?
    var eventDescription: String?
    var eventName: String?
    var imageUrl: String?
    var posterId: String?
    var posterName: String?
    var id: String?
    var image: UIImage?
    var interestedUserDictionary: Dictionary<String, String>?
    var interestedUserIds: [String]?
    var latitude: Double?
    var longitude: Double?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        eventDate                  <- map["date"]
        eventDescription           <- map["description"]
        eventName                  <- map["name"]
        imageUrl                   <- map["pictureURL"]
        posterId                   <- map["posterId"]
        interestedUserDictionary   <- map["Interested"]
        id                         <- map["postId"]
        latitude                   <- map["latitude"]
        longitude                  <- map["longitude"]
        posterName                 <- map["posterName"]
        
    }
    
    func addInterestedUser(userID: String){
        if self.interestedUserIds == nil {
            self.interestedUserIds =  [userID]
        }
        else{
            self.interestedUserIds!.append(userID)
        }
    }
    
    func getInterestedUserIds() -> [String]{
        if interestedUserDictionary != nil && self.interestedUserIds == nil{
            self.interestedUserIds = Array(self.interestedUserDictionary!.values) as! [String]
        }
        if self.interestedUserIds == nil {
            return []
        }
        else{
            return self.interestedUserIds!
        }
    }
    func getNumInterested() -> Int {
        return getInterestedUserIds().count
    }
    
    func getPostDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: eventDate!)!
        }
    
    
    func getPicture() -> Promise<Bool> {
        return Promise { fufill, _ in
            if self.image == nil {
                let cache = Shared.imageCache
                if let url = URL(string: self.imageUrl!){
                    cache.fetch(URL: url).onSuccess({ img in
                        self.image = img
                        fufill(true)
                    })
                }
            }
        }
    }
    

}
//    var eventDescription: String?
//    var eventDate: String?
//    var eventName: String?
//    var posterName: String?
//    var id: String?
//    var interested = [String]()
//    var image : UIImage?
//
//    init(id: String, postDict: [String:Any]?) {
//        self.id = id
//        if let text = postDict!["text"] as? String {
//            self.eventDescription = text
//        }
//        if let date = postDict!["date"] as? String {
//            self.eventDate = date
//        }
//        if let name = postDict!["name"] as? String {
//            self.eventName = name
//        }
//        if let poster = postDict!["poster"] as? String {
//            self.posterName = poster
//        }
//        if let interested = postDict!["interested"] as? [String] {
//            self.interested = interested
//        }
//    }
//
//    func getProfilePic(withBlock: @escaping () -> ()){
//        //print(self.name)
//        let ref = Storage.storage().reference().child("/Posts/\(id!)")
//        ref.getData(maxSize: 1 * 2048 * 2048) { (data, error) in
//            if error != nil {
//            } else {
//                self.image = UIImage(data: data!)
//            }
//            withBlock()
//        }
//    }
    

