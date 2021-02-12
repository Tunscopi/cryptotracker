//
//  Addcurrencycontroller.swift
//  cryptoTracker
//
//  Created by Tunscopi on 3/31/18.
//  Copyright © 2018 Ayotunde. All rights reserved.
//

import UIKit

protocol AddFavoriteCryptoDelegate {
  func didAddCryptoToFavorite(currency: String)
}

class Addcurrencycontroller: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchResultsUpdating {
  
  var delegate: AddFavoriteCryptoDelegate?
  
  let searchController = UISearchController(searchResultsController: nil)
  
  var availableCurrencies = ["BTC", "ETH", "NEO", "LTC", "BCH", "ADA", "VEN", "ZCL", "XEM", "DGB", "POWR", "XLM", "XVG", "QTUM"]
  
  var filteredCurrencies = [String]()
  
  let firebaseClient = FirebaseClient.shared

  struct currencyWithSelectedState {
    var currency: String
    var isSelected: Bool
  }

  var currenciesWithSelectedState = [currencyWithSelectedState]()
  
  var filteredCurrenciesWithSelectedState = [currencyWithSelectedState]()
  
  lazy var searchBar = UISearchBar()
  
  let tableView: UITableView = {
    let tbView = UITableView()
    tbView.register(Cryptocell.self, forCellReuseIdentifier: "cryptoCell")
    tbView.translatesAutoresizingMaskIntoConstraints = false
    return tbView
  }()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    
    tableView.backgroundColor = UIColor.darkGray
    
    searchBar.delegate = self
    
    title = "Add"
    view.backgroundColor = .white
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAddCurrency))
    
    setupSearchBar()
    
    setupUI()
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    filteredCurrencies = availableCurrencies
    addSelectedStateToCurrencyAndReloadTable()
  }
  
  func addSelectedStateToCurrencyAndReloadTable() {
    for currency in availableCurrencies {
      let newCurrencyWithState = currencyWithSelectedState(currency: currency, isSelected: false)
      self.currenciesWithSelectedState.append(newCurrencyWithState)
    }
    
    handleReloadTable()
  }
  
  @objc func handleAddCurrency() {
    print("adding currency")
    
    let selectedCurrenciesToAdd = filteredCurrenciesWithSelectedState.filter({ (currencyWithState) -> Bool in
      return currencyWithState.isSelected
    })
    
    for selectedCurrency in selectedCurrenciesToAdd {
      addCurrencyToUserFavorites(withCurrency: selectedCurrency.currency)
      
      delegate?.didAddCryptoToFavorite(currency: selectedCurrency.currency)
    }
    
    navigationController?.popViewController(animated: true)
  }
  
  private func addCurrencyToUserFavorites(withCurrency currency: String) {
    firebaseClient.updateToDB(currency: currency)
  }
  
  @objc func handleCancelModal() {
    navigationController?.popViewController(animated: true)
  }
  
  private func setupSearchBar() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
    
    definesPresentationContext = true
  }
  
  func isFiltering() -> Bool {
    let searchBarIsEmpty = searchController.searchBar.text?.isEmpty ?? true
    return searchController.isActive && !searchBarIsEmpty
  }
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredCurrenciesWithSelectedState = currenciesWithSelectedState.filter({ (crypto) -> Bool in
      return crypto.currency.lowercased().contains(searchText.lowercased())
    })
    
    handleReloadTable()
  }
  
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    filterContentForSearchText(searchText)
  }
  
  private func handleReloadTable() {
    if !isFiltering() {
      filteredCurrenciesWithSelectedState = currenciesWithSelectedState
    }
    
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
  
  func hideAddIcon() {
    if let addButton = self.navigationItem.rightBarButtonItem {
      addButton.isEnabled = false
      addButton.tintColor = UIColor.clear
    }
  }
  
  func showAddIcon() {
    if let addButton = self.navigationItem.rightBarButtonItem {
      addButton.isEnabled = true
      addButton.tintColor = UIColor.orange
    }
  }
  
  private func setupUI() {
    view.addSubview(tableView)
    
    // place directly under navbar
    if #available(iOS 11.0, *) {
      let guide = self.view.safeAreaLayoutGuide
      tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
      tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
      tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    } else {
      NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top,
                         multiplier: 1.0, constant: 0).isActive = true
      NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
      NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
      NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom,
                         multiplier: 1.0, constant: 0).isActive = true
    }
  }
}
