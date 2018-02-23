//
//  EventCollectionViewCell.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/20/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    
    var eventPost: Post!
    
    var eventImageView: UIImageView!
    //var eventName: String!
    //var posterName: String!
    //var numInterested = [String]()
    //var image: UIImage!
    //var eventDescription: String!
    //var id: String!
    
    var eventNameLabel: UILabel!
    var posterNameLabel: UILabel!
    var numInterestedLabel: UILabel!
    
    override func awakeFromNib() {
        let view = UIView(frame: frame)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        setupCell()
    }
    func setupCell() {
        eventImageView = UIImageView(frame: CGRect(x:10, y:15, width: 110, height:110))
        eventImageView.layer.cornerRadius = 10
        eventImageView.clipsToBounds = true
        eventImageView.contentMode = .scaleAspectFit
        eventImageView.layer.borderColor = UIColor.black.cgColor
        eventImageView.image = eventPost.image  //delete later
        contentView.addSubview(eventImageView)
        
        eventNameLabel = UILabel(frame: CGRect(x:125, y:15, width: contentView.frame.width, height: 40))
        eventNameLabel.text = eventPost.eventName
        eventNameLabel.font = eventNameLabel.font.withSize(35)
        contentView.addSubview(eventNameLabel)
        
        posterNameLabel = UILabel(frame: CGRect(x:125, y:70, width: contentView.frame.width, height: 25))
        posterNameLabel.text = eventPost.posterName
        contentView.addSubview(posterNameLabel)
        
        numInterestedLabel = UILabel(frame: CGRect(x:125, y:105, width: contentView.frame.width, height: 15))
        numInterestedLabel.text = "\(eventPost.interested.count) people interested" //delete later
        contentView.addSubview(numInterestedLabel)

        
    }
}
