//
//  InterestedPplTableViewCell.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 3/3/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class InterestedPplTableViewCell: UITableViewCell {
    var userImageView: UIImageView!
    var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImageView = UIImageView(frame: CGRect(x:20, y:15, width: 77, height:77))
        userImageView.layer.cornerRadius = 10
        userImageView.clipsToBounds = true
        userImageView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(userImageView) //remember to add UI elements to the contentView not the cell itself
        
        name = UILabel(frame: CGRect(x:125, y:25, width: 240, height:30))
        name.textColor = UIColor.black
        name.font = UIFont.boldSystemFont(ofSize: 25)
        contentView.addSubview(name)
    }

}
