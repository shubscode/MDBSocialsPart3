//
//  InterestedPplTableViewCell.swift
//  MDB Socials
//
//  Created by Shubham Gupta on 3/3/18.
//  Copyright © 2018 Shubham Gupta. All rights reserved.
//

import UIKit

class InterestedPplTableViewCell: UITableViewCell {
    var imageView: UIImageView!
    var name: UILabel!
    
    override func awakeFromNib() {
        imageView = UIImageView(frame: CGRect(x:20, y:15, width: 77, height:77))
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.black.cgColor
        contentView.addSubview(imageView) //remember to add UI elements to the contentView not the cell itself
        
        name = UILabel(frame: CGRect(x:125, y:25, width: 240, height:30))
        name.textColor = UIColor.black
        name.font = UIFont.boldSystemFont(ofSize: 25)
        contentView.addSubview(name)
    }

}
