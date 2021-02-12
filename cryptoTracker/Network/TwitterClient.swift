//
//  TwitterClient.swift
//  cryptoTracker
//
//  Created by Tunscopi on 3/31/18.
//  Copyright © 2018 Ayotunde. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
  static let shared = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "f8MOhEaHUizuWW7ajldI1Jh6D", consumerSecret: "IpSlhgdRG3pHH5CwSXii2ghue8dAvGp2PskASplz2JtPNmx0zY")
  
  var loginSuccess: (() -> ())?
  var loginFailure: ((Error) -> ())?
  
  func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
    loginSuccess = success
    loginFailure = failure
    
    TwitterClient.shared?.deauthorize()
    TwitterClient.shared?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterClient://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
      print("Request Token received")
      
      let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token!)!)")!
      self.open(_url: url)
      
    }) { (error:Error?) -> Void in
      print ("error: \(error!.localizedDescription)")
      self.loginFailure?(error!)
    }
  }
  
  
  func logout() {
    UserDefaults.standard.removeObject(forKey: "user")
    
    if UserDefaults.standard.data(forKey: "user") == nil {
      print ("Succesfully cleared user info")
    }
    deauthorize()
  }
  
  
  func open(_url: URL) {
    if #available(iOS 10, *) {
      UIApplication.shared.open(_url, options: [:], completionHandler: {(success) in
        print("Open url: \(success)")
      })
    }
    else {
      _ = UIApplication.shared.openURL(_url)
    }
  }
  
  func cryptoTweets(currency: String, success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
    get("1.1/search/tweets.json", parameters: currency, progress: nil, success: {(_: URLSessionDataTask, response:
      Any?) -> Void in
      let dictionaries = response as! [NSDictionary]
      let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
      
      success(tweets)
      
    }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
      failure(error)
    })
    
  }
  
  
//  func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
//    get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {(_: URLSessionDataTask, response:
//      Any?) -> Void in
//      let dictionaries = response as! [NSDictionary]
//      let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
//
//      success(tweets)
//
//    }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
//      failure(error)
//    })
//
//  }
}

