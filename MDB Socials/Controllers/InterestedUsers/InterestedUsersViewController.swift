//
//  InterestedUsersViewController.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 3/3/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class InterestedUsersViewController: UIViewController {

    var userIDArray: [String]?
    var usersArray: [Users] = []
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        self.navigationItem.title = "Interested Users"
        setupTableView()
    }
    
    func setupTableView(){
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.register(EventCollectionViewCell.self, forCellReuseIdentifier: "user")
        view.addSubview(tableView)
    }
    
    func getUsers(){
        if userIDArray != nil {
            for u in userIDArray!{
                print("Getting User")
                FirebaseAPIClient.getUserWithId(id: u).then {user in
                    self.usersArray.append(user)
                    }.then {
                        self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUsers()
    }
}

extension InterestedUsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! EventCollectionViewCell
        let user = usersArray[indexPath.row]
        cell.awakeFromNib()
        cell.titleLabel.text = user.name!
        cell.posterNameLabel.text = user.username!
        cell.startLoadingView()
        if user.profilePicture == nil {
            user.getPicture().then { picture in
                DispatchQueue.main.async {
                    user.profilePicture = picture
                    cell.mainImageView.image = picture
                    cell.stopLoadingView()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }


}
