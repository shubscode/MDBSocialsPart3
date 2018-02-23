//
//  FeedViewController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 2/19/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FeedViewController: UIViewController {

    var eventCollectionView: UICollectionView!
    
    var customBlue = UIColor(hue: 0.5472, saturation: 0.75, brightness: 0.94, alpha: 1.0)
    var customWhite = UIColor(hue: 0.5972, saturation: 0.24, brightness: 0.95, alpha: 1.0)
    
    //var newEventButton: UIButton!
    var logoutButton: UIButton!
    
    var posts : [Post] = []
    
    var postToPass : Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPosts()
        fetchPosts()
        changePosts()
        
        let item1 = UIBarButtonItem(title: "Add New Event", style: .plain, target: self, action: #selector(createNewEvent))
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        setUpCollectionView()
        
        let item2 = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutUser))
        self.navigationItem.setLeftBarButtonItems([item2], animated: true)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false;
    }
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        eventCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        eventCollectionView.backgroundColor = UIColor.white
        eventCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "eventCell")
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        eventCollectionView.layer.backgroundColor = customBlue.cgColor
        view.addSubview(eventCollectionView)
    }
    
    @objc func createNewEvent() {
        self.performSegue(withIdentifier: "toNewEvent", sender: self)
    }
    
    @objc func logoutUser() {
        UserAuthHelper.logOut(withBlock:
            {self.performSegue(withIdentifier: "logoutSegue", sender: self)});
        
        
    }
    
    func fetchPosts() {
        let ref = Database.database().reference()
        ref.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = Post(id: snapshot.key, postDict: snapshot.value as! [String : Any]?)
            self.posts.insert(post, at: 0)
            post.getProfilePic(withBlock: {
                self.eventCollectionView.reloadData()
            })
        })
    }
    
    func changePosts() {
        let ref = Database.database().reference()
        ref.child("Posts").observe(.childChanged, with: { (snapshot) in
            self.eventCollectionView.reloadData()
        })
    }
    
    func setupPosts() {
        let cvLayout = UICollectionViewFlowLayout()
        eventCollectionView = UICollectionView(frame: CGRect(x: 0, y: view.frame.height * 0.12, width: view.frame.width, height: view.frame.height * 0.88), collectionViewLayout: cvLayout)
        eventCollectionView.delegate = self
        eventCollectionView.dataSource = self
        eventCollectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "eventCell")
        eventCollectionView.backgroundColor = UIColor(red: 67.0/255.0, green: 130.0/255.0, blue: 232.0/255.0, alpha: 1.0)
        view.addSubview(eventCollectionView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.selectedPost = postToPass
        }
    }

    

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = eventCollectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCollectionViewCell
        let selectedEvent = posts[indexPath.row]

        cell.eventName = selectedEvent.eventName
        cell.image = selectedEvent.image
        cell.posterName = selectedEvent.posterName
        cell.numInterested = selectedEvent.interested
        cell.eventDescription = selectedEvent.eventDescription
        cell.id = selectedEvent.id
        cell.awakeFromNib()
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        postToPass = posts[indexPath.row]
        if postToPass.image != nil{
            performSegue(withIdentifier: "toEventDetails", sender: self)
        }
    }
    
    
}
