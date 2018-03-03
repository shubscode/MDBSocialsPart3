//
//  PostCollectionCollectionViewCell.swift
//  MDBSocials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    var imageView : UIImageView!
    var image : UIImage!
    var title : String!
    var content : String!
    var date : String!
    var name : String!
    var interested : String!
    
    var postTitle : UILabel!
    var postContent : UILabel!
    var posterName : UILabel!
    var postDate : UILabel!
    var postInterested : UILabel!
    
    override func awakeFromNib() {
        createPostImage()
        createPostTitle()
        createPostContent()
        createPosterName()
        createPostDate()
        createInterested()
        configureCell()
    }
    
    //Create the image to post
    func createPostImage() {
        
        imageView = UIImageView(frame: CGRect(x: 0, y: contentView.frame.height * 0.05, width: contentView.frame.width, height: contentView.frame.height * 0.9))
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        contentView.addSubview(imageView)
    }
    
    //Create the title to post
    func createPostTitle() {
        postTitle = UILabel(frame: CGRect(x: contentView.frame.width * 0.05, y: contentView.frame.height * 0.05, width: contentView.frame.width * 0.5, height: contentView.frame.height * 0.2))
        postTitle.textColor = .white
        
        postTitle.layer.shadowColor = UIColor.black.cgColor
        postTitle.layer.shadowOffset = CGSize(width: 0, height: 0)
        postTitle.layer.shadowOpacity = 1.0
        postTitle.layer.shadowRadius = 1.0
        
        postTitle.text = "\(title!)"
        contentView.addSubview(postTitle)
    }
    
    //Create the name of poster to post
    func createPosterName(){
        posterName = UILabel(frame: CGRect(x: contentView.frame.width * 0.05, y: contentView.frame.height * 0.30, width: contentView.frame.width * 0.5, height: contentView.frame.height * 0.13))
        posterName.text = "Created by: \(name!)"
        posterName.textColor = .white
        posterName.layer.shadowColor = UIColor.black.cgColor
        posterName.layer.shadowOffset = CGSize(width: 0, height: 0)
        posterName.layer.shadowOpacity = 1.0
        posterName.layer.shadowRadius = 1.0
        contentView.addSubview(posterName)
    }
    
    //Create the date to post
    func createPostDate() {
        postDate = UILabel(frame: CGRect(x: contentView.frame.width * 0.60, y: contentView.frame.height * 0.1, width: contentView.frame.width * 0.35, height: contentView.frame.height * 0.2))
        postDate.text = date
        postDate.textAlignment = .right
        postDate.textColor = .white
        postDate.layer.shadowColor = UIColor.black.cgColor
        postDate.layer.shadowOffset = CGSize(width: 0, height: 0)
        postDate.layer.shadowOpacity = 1.0
        postDate.layer.shadowRadius = 1.0
        contentView.addSubview(postDate)
    }
    
    //Create the content to post
    func createPostContent(){
        postContent = UILabel(frame: CGRect(x: contentView.frame.width * 0.05, y: contentView.frame.height * 0.5, width: contentView.frame.width * 0.9, height: contentView.frame.height * 0.20))
        postContent.text = content
        postContent.numberOfLines = 3
        postContent.layer.shadowColor = UIColor.black.cgColor
        postContent.layer.shadowOffset = CGSize(width: 0, height: 0)
        postContent.layer.shadowOpacity = 1.0
        postContent.layer.shadowRadius = 1.0
        postContent.textColor = .white
        contentView.addSubview(postContent)
    }
    
    func createInterested(){
        postInterested = UILabel(frame: CGRect(x: contentView.frame.width * 0.05, y: contentView.frame.height * 0.75, width: contentView.frame.width * 0.9, height: contentView.frame.height * 0.15))
        postInterested.text = interested
        postInterested.textAlignment = .right
        postInterested.layer.shadowColor = UIColor.black.cgColor
        postInterested.layer.shadowOffset = CGSize(width: 0, height: 0)
        postInterested.layer.shadowOpacity = 1.0
        postInterested.layer.shadowRadius = 1.0
        postInterested.textColor = .white
        contentView.addSubview(postInterested)
    }
    
    //Create the rounded corner and the shadow
    func configureCell(){
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
}

