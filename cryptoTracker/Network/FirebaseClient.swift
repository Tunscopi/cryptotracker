//
//  FirebaseClient.swift
//  cryptoTracker
//
//  Created by Tunscopi on 3/31/18.
//  Copyright © 2018 Ayotunde. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseClient: NSObject {
  static let shared = FirebaseClient()
  
  func updateToDB(currency: String) {
    let ref = Database.database().reference().child("user-currencies")
    
    // create dictionary
    // update to firebase
    
    ref.updateChildValues([currency: 1])
  }
  
  func pullFromDB() {
    let ref = Database.database().reference().child("user-currencies")
    
    ref.observe(.childAdded) { (snapshot) in
      //print(snapshot.value)
    }
  }
}
