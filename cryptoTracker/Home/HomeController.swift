//
//  HomeController.swift
//  cryptoTracker
//
//  Created by Tunscopi on 3/31/18.
//  Copyright © 2018 Ayotunde. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddFavoriteCryptoDelegate {
  
  func didAddCryptoToFavorite(currency: String) {
    favoriteCurrencies.append(currency)
    
    let newIndexPath = IndexPath(row: favoriteCurrencies.count - 1, section: 0)
    tableView.insertRows(at: [newIndexPath], with: .automatic)
  }
  
  let twitterClient = TwitterClient.shared

  var favoriteCurrencies = ["Hmm, I just hope those that attended had fun", "do all these beychella people even have finals?", "Enter your comment here..."]
  
  let myFavoriteCryptosLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 10)
    label.text = "Public comments "
    label.textColor = UIColor.viewsLightBlue
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  let tableView: UITableView = {
    let tbView = UITableView()
    tbView.register(Cryptocell.self, forCellReuseIdentifier: "cryptoCell")
    tbView.backgroundColor = UIColor.viewsDarkGray
    return tbView
  }()
  
  let tweetTableView: UITableView = {
    let tweetTbView = UITableView()
    tweetTbView.register(tweetCell.self, forCellReuseIdentifier: "tweetCell")
    return tweetTbView
  }()
  
  let customView: UITextField = {
    let tfield = UITextField()
    tfield.backgroundColor = UIColor.white
    tfield.text = "Enter your comment here"
    tfield.textColor = UIColor.lightGray
    tfield.font = UIFont.boldSystemFont(ofSize: 13)
    tfield.translatesAutoresizingMaskIntoConstraints = false
    return tfield
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = customView
    
    tableView.allowsSelection = false
    
    title = "CryptoCurrencies"
    view.backgroundColor = UIColor.viewsDarkGray
    
    navigationController?.navigationBar.prefersLargeTitles = true
    
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(showMenu))
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "orange-add"), style: .plain, target: self, action: #selector(handleAddCurrency))
    
    setupUI()
    
  }
  
  @objc private func handleAddCurrency() {
    let addCurrencyController = Addcurrencycontroller()
    addCurrencyController.delegate = self
    navigationController?.pushViewController(addCurrencyController, animated: true)
  }
  
  @objc private func showMenu() {
    
  }
  
  private func setupUI() {
    view.addSubview(myFavoriteCryptosLabel)
    myFavoriteCryptosLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 190).isActive = true
    myFavoriteCryptosLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18).isActive = true
    myFavoriteCryptosLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    myFavoriteCryptosLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
    
    view.addSubview(tableView)
    tableView.frame = CGRect(x: 18, y: 230, width: view.frame.width-32, height: view.frame.height )
    tableView.backgroundColor = UIColor.darkGray
    
    view.addSubview(customView)
    customView.frame = CGRect(x: 18, y: 330, width: view.frame.width-32, height: CGFloat(40.0) )
  }

}

extension UIColor {
  static let viewsOrange = UIColor(red: 212/255, green: 93/255, blue: 0/255, alpha: 1)
  static let viewsLightBlue = UIColor(red: 72/255, green: 169/255, blue: 197/255, alpha: 1)
  static let viewsOffWhite = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
  static let viewsLightOrange = UIColor(red: 204/255, green: 101/255, blue: 23/255, alpha: 1)
  static let viewsDarkGray = UIColor(red: 66/255, green: 64/255, blue: 64/255, alpha: 1)
  static let viewsLightBlack = UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
}

