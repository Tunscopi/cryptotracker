//
//  AddCryptoCurrencyController+UITableView.swift
//  cryptoTracker
//
//  Created by Tunscopi on 3/31/18.
//  Copyright © 2018 Ayotunde. All rights reserved.
//

import UIKit

extension Addcurrencycontroller {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredCurrenciesWithSelectedState.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cryptoCell", for: indexPath) as! Cryptocell
    
    cell.cryptoCurrency = filteredCurrenciesWithSelectedState[indexPath.row].currency
    
    if filteredCurrenciesWithSelectedState[indexPath.row].isSelected {
      cell.accessoryType = .checkmark
      cell.tintColor = UIColor.orange
      
    } else {
      cell.accessoryType = .none
    }
    
    cell.selectionStyle = .none
        
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    filteredCurrenciesWithSelectedState[indexPath.row].isSelected = !filteredCurrenciesWithSelectedState[indexPath.row].isSelected
    
    hideOrDisplayAddButton()

    // Reload cell
    tableView.beginUpdates()
    tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
  
  private func hideOrDisplayAddButton() {
    var shouldShowAddButton = false
    
    for currency in filteredCurrenciesWithSelectedState {
      if currency.isSelected {
        shouldShowAddButton = true
        break
      }
    }
    
    if shouldShowAddButton {
      showAddIcon()
      
    } else {
      hideAddIcon()
    }
  }
}
