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
    var filteredUsers: [Users] = []
    
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
        tableView.register(InterestedPplTableViewCell.self, forCellReuseIdentifier: "user")
        view.addSubview(tableView)
    }
    
    func getUsers(){
        if userIDArray != nil {
            for u in userIDArray!{
                print("Getting User")
                FirebaseAPIClient.getUserWithId(id: u).then {user in
                    self.filteredUsers.append(user)
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
        print("FILTERED USERS ARE \(filteredUsers)")
        return filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! InterestedPplTableViewCell
        let user = filteredUsers[indexPath.row]
        cell.awakeFromNib()
        print(userIDArray)
        print("CREATING USERS")
        print(user)
        print(user.id)
        print(user.name)
        cell.name.text = user.name!
        if user.profilePicture == nil {
            user.getPicture().then { picture in
                DispatchQueue.main.async {
                    user.profilePicture = picture
                    cell.userImageView.image = picture
                }
            }
        }
        
            
        
        
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }


}
