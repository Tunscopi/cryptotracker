//
//  HomeController+UITableView.swift
//  cryptoTracker
//
//  Created by Tunscopi on 3/31/18.
//  Copyright © 2018 Ayotunde. All rights reserved.
//

import UIKit

extension HomeController {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteCurrencies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cryptoCell", for: indexPath) as! Cryptocell
    cell.cryptoCurrency = favoriteCurrencies[indexPath.row]
  
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("selected row")
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    // TODO: Attempting to hide Crypto, this is only locally though right now
    
    let currency = self.favoriteCurrencies[indexPath.row]
    
    for (index, curr) in favoriteCurrencies.enumerated() {
      if curr == currency {
        self.favoriteCurrencies.remove(at: index)
      }
    }
    
    tableView.reloadData()
  }

}
