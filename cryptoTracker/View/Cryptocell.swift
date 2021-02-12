//
//  cryptocell.swift
//  cryptoTracker
//
//  Created by Tunscopi on 3/31/18.
//  Copyright © 2018 Ayotunde. All rights reserved.
//

import UIKit

class Cryptocell: UITableViewCell {
  
  var cryptoCurrency: String? {
    didSet {
      cryptoCurrencyLabel.text = cryptoCurrency
    }
  }
  
  var cryptoCurrencyLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 9)
    label.textColor = UIColor.white
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = UIColor.viewsDarkGray
    
    addSubview(cryptoCurrencyLabel)
    cryptoCurrencyLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    cryptoCurrencyLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
    cryptoCurrencyLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    cryptoCurrencyLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
