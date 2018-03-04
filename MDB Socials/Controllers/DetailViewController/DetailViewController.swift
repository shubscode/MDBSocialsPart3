//
//  DetailViewController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class DetailViewController: UIViewController {
    
    //Background Image
    var backgroundImage: UIImageView!
    
    var mapView: MKMapView!
    var getDirectionsButton: UIButton!
    
    var whosInterested: UIButton!
    
    //Post Given
    var post: Post!
    
    //Post Title
    var postTitleTextField: UILabel!
    
    //Post Body
    var postBodyTextField: UILabel!
    
    //Post Date
    var postDateTextField: UILabel!
    
    //Post Location
    var postLocationTextField: UILabel!
    
    //Event Image View
    var eventImageView : UIImageView!
    
    //Interested Button
    var interestedButton : UIButton!
    
    
    
    override func viewDidLoad() {
        //self.hideKeyboardWhenTappedAround()
        super.viewDidLoad()
        createBackground()
        createEventImageView()
        createPostTitle()
        createPostBody()
        createPostDate()
        createInterestedButton()
        
        createMapView()
        createGetDirectionsButton()
    }
    
    //Create background
    func createBackground() {
        backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.backgroundColor = UIColor(red: 67.0/255.0, green: 130.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        view.addSubview(backgroundImage)
    }

    
    //Create the EventImageView
    func createEventImageView() {
        eventImageView = UIImageView(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.13, width: view.frame.width * 0.6, height: view.frame.height * 0.27))
        eventImageView.layer.cornerRadius = 8
        eventImageView.clipsToBounds = true
        eventImageView.backgroundColor = .white
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.image = post.image!
        view.addSubview(eventImageView)
    }
    
    func createMapView() {
        mapView = MKMapView(frame: CGRect(x: view.frame.width * 0.65, y: view.frame.height * 0.13, width: view.frame.width * 0.35, height: view.frame.height * 0.27))
        mapView.mapType = .standard
        mapView.layer.cornerRadius = 10
        mapView.layer.masksToBounds = true
        view.addSubview(mapView)
    }
    
    
    func createPostTitle() {
        postTitleTextField = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.42, width: view.frame.width * 0.45, height: view.frame.height * 0.16))
        postTitleTextField.backgroundColor = .white
        //postTitleTextField.roundCorners(corners: [.topLeft], radius: 8)
        postTitleTextField.layer.cornerRadius = 8
        postTitleTextField.numberOfLines = 0
        postTitleTextField.lineBreakMode = .byWordWrapping
        postTitleTextField.text = " \(post.eventName!)\rBy: \(post.posterName!)"
        postTitleTextField.textAlignment = .center
        
        //postTitleTextField.sizeToFit()
        
        
        view.addSubview(postTitleTextField)
        
        
    }
    
    //Create date of the event
    func createPostDate() {
        postDateTextField = UILabel(frame: CGRect(x: view.frame.width * 0.5, y: view.frame.height * 0.42, width: view.frame.width * 0.45, height: view.frame.height * 0.16))
        postDateTextField.backgroundColor = .white
        postDateTextField.text = "\(post.eventDate!)"
        postDateTextField.textAlignment = .center
        //postDateTextField.roundCorners(corners: [.topRight], radius: 8)
        postDateTextField.layer.cornerRadius = 8
        view.addSubview(postDateTextField)
    }
    
    //Create the body of the function
    func createPostBody() {
        postBodyTextField = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.60, width: view.frame.width * 0.9, height: view.frame.height * 0.15))
        postBodyTextField.text = post.eventDescription!
        postBodyTextField.numberOfLines = 5
        //postBodyTextField.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
        postBodyTextField.layer.cornerRadius = 8
        postBodyTextField.backgroundColor = .white
        view.addSubview(postBodyTextField)
    }
    
    //Create a button to increase the interested number
    func createInterestedButton() {
        interestedButton = UIButton(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.8, width: view.frame.width * 0.2667, height: view.frame.height * 0.12))
        interestedButton.layer.cornerRadius = 8
        interestedButton.backgroundColor = UIColor.lightGray
        interestedButton.backgroundColor = .white
        interestedButton.setTitle("Interested?", for: .normal)
        interestedButton.setTitleColor(UIColor(red: 67.0/255.0, green: 130.0/255.0, blue: 232.0/255.0, alpha: 1.0), for: .normal)
        if(post.getInterestedUserIds().contains((Auth.auth().currentUser?.uid)!)){
            interestedButton.isEnabled = false
            interestedButton.setTitle("Already interested", for: .normal)
        } else {
            interestedButton.addTarget(self, action: #selector(increaseInterested), for: .touchUpInside)
        }
        view.addSubview(interestedButton)
    }
    
    func createGetDirectionsButton() {
        getDirectionsButton = UIButton(frame: CGRect(x: view.frame.width * 0.3167, y: view.frame.height * 0.8, width: view.frame.width * 0.2667, height: view.frame.height * 0.12))
        getDirectionsButton.addTarget(self, action: #selector(getDirections), for: .touchUpInside)
        getDirectionsButton.layer.cornerRadius = 10
        getDirectionsButton.setTitle("Get Directions", for: .normal)
        getDirectionsButton.setTitleColor(Constants.loginColor, for: .normal)
        getDirectionsButton.backgroundColor = .white
        getDirectionsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        view.addSubview(getDirectionsButton)
    }
    
    func createWhosInterested() {
        getDirectionsButton = UIButton(frame: CGRect(x: view.frame.width * 0.5833, y: view.frame.height * 0.8, width: view.frame.width * 0.2667, height: view.frame.height * 0.12))
        getDirectionsButton.addTarget(self, action: #selector(whosInterestedSegue), for: .touchUpInside)
        getDirectionsButton.layer.cornerRadius = 10
        getDirectionsButton.setTitle("Who's Interested", for: .normal)
        getDirectionsButton.setTitleColor(Constants.loginColor, for: .normal)
        getDirectionsButton.backgroundColor = .white
        getDirectionsButton.titleLabel?.adjustsFontSizeToFitWidth = true
        view.addSubview(getDirectionsButton)
    }
    
    @objc func getDirections(){
        let urlString = "http://maps.apple.com/?saddr=&daddr=\(post.latitude!),\(post.longitude!)"
        let url = URL(string: urlString)
        UIApplication.shared.open(url!)
    }
    
    
    @objc func whosInterestedSegue(){
        performSegue(withIdentifier: "toWhosInterested", sender: self)
    }
    
    //Function to increase the number of those interested
    @objc func increaseInterested() {
        
        FirebaseAPIClient.updateInterested(postId: post.id!, userId: (UserAuthHelper.getCurrentUser()?.uid)!).then { success -> Void in
            print("Updated interested")
            
            self.interestedButton.isEnabled = false
            self.interestedButton.setTitle("You are already interested", for: .normal)
            self.post.addInterestedUser(userID: (UserAuthHelper.getCurrentUser()?.uid)!)
            //self.interestedLabel.text = "Members Interested: " + String(describing: self.viewController.post.getInterestedUserIds().count)
        }
        
//        interestedButton.isEnabled = false
//        interestedButton.setTitle("You are already interested", for: .normal)
//        post.addInterestedUser(userID: (Auth.auth().currentUser?.uid)!)
//        let postRef = Database.database().reference().child("Posts").child(post.id!)
//        let update = ["interested" : post.interested]
//        postRef.updateChildValues(update)
    }
    

}
