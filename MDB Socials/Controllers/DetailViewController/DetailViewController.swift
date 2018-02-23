//
//  DetailViewController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var eventImageView: UIImageView!
    var eventPosterLabel: UILabel!
    var eventNameLabel: UILabel!
    var numInterestedLabel: UILabel!
    var eventDateLabel: UILabel!
    var locationLabel: UILabel!
    var descriptionLabel: UILabel!
    
    var selectedPost: Post!
    
    var interestedButton: UIButton!

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()

    }
    func setup() {
        print("THE POST IS")
        print(selectedPost)
        print(selectedPost!.posterName!)
        eventImageView = UIImageView(frame: CGRect(x: 20, y: 100, width: view.bounds.width - 38, height: 200));
        eventImageView.image = selectedPost.image
        eventImageView.contentMode = .scaleAspectFit
        eventImageView.clipsToBounds = true
        eventImageView.layer.cornerRadius = 10
        view.addSubview(eventImageView)
        
        //eventNameLabel = UILabel(frame: CGRect())
        
        eventNameLabel = UILabel(frame: CGRect(x: 30, y: 340, width: view.frame.midX - 20, height: 30))
        eventNameLabel.text = "Event Name: \(selectedPost!.eventName!)"
        view.addSubview(eventNameLabel)
        
        eventPosterLabel = UILabel(frame: CGRect(x: 30, y: 380, width: view.frame.midX - 20, height: 30))
        eventPosterLabel.text = "Hosted By: \(selectedPost!.posterName!)"
        view.addSubview(eventPosterLabel)
        
        numInterestedLabel = UILabel(frame: CGRect(x: 30, y: 420, width: view.frame.midX - 20, height: 30))
        numInterestedLabel.text = "\(selectedPost!.interested.count) are interested!"
        view.addSubview(numInterestedLabel)
        
        eventDateLabel = UILabel(frame: CGRect(x: 30, y: 460, width: view.frame.midX - 20, height: 30))
        eventDateLabel.text = "When: \(selectedPost!.eventDate!)"
        view.addSubview(eventDateLabel)
        
//        locationLabel = UILabel(frame: CGRect(x: 30, y: 500, width: view.frame.midX - 20, height: 30))
//        locationLabel.text = "HP: \(selectedPost!.eventLocation!)"
//        view.addSubview(locationLabel)
        
        descriptionLabel = UILabel(frame: CGRect(x: 30, y: 540, width: view.frame.midX - 20, height: 50))
        descriptionLabel.text = "HP: \(selectedPost!.eventDescription!)"
        view.addSubview(descriptionLabel)
        
        
        
    }

    

}
