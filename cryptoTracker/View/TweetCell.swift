//
//  TweetCell.swift
//  cryptoTracker
//
//  Created by Tunscopi on 3/31/18.
//  Copyright © 2018 Ayotunde. All rights reserved.
//

import Foundation
import UIKit

class tweetCell: UITableViewCell {
  
  // Observer to update whenever Tweet changes
  var tweet: Tweet? {
    didSet{
      tweetTextLabel.text = tweet?.text
      timestamp.text = "\(tweet?.timeAgo)"
      usernameLabel.text = tweet?.user?.name
      handleLabel.text = "@\((tweet?.user?.screenname)!)"
    }
  }
  
  let usernameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var timestamp: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var tweetTextLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var handleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    addSubview(usernameLabel)
    usernameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    usernameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    usernameLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
    usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    
    addSubview(timestamp)
    timestamp.topAnchor.constraint(equalTo: topAnchor).isActive = true
    timestamp.heightAnchor.constraint(equalToConstant: 15).isActive = true
    timestamp.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    
    addSubview(tweetTextLabel)
    tweetTextLabel.topAnchor.constraint(equalTo: usernameLabel.topAnchor, constant: 10).isActive = true
    tweetTextLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    tweetTextLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    tweetTextLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5).isActive = true
    
    addSubview(handleLabel)
    handleLabel.topAnchor.constraint(equalTo: usernameLabel.topAnchor).isActive = true
    handleLabel.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor, constant: 10).isActive = true
    handleLabel.bottomAnchor.constraint(equalTo: usernameLabel.bottomAnchor).isActive = true
   
  }
  
  
}
