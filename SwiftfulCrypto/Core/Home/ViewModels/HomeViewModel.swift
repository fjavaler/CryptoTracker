//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/11/21.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
  
  // MARK: Properties
  @Published var statistics: [StatisticModel] = [
    StatisticModel(title: "Title", value: "Value", percentageChange: 1),
    StatisticModel(title: "", value: "Value"),
    StatisticModel(title: "", value: "Value"),
    StatisticModel(title: "", value: "Value", percentageChange: -7)
  ]
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  @Published var searchText: String = ""
  private let dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: Init
  init() {
    addSubscribers()
  }
  
  // MARK: Methods
  func addSubscribers() {
    
    // Not needed since logic is already being performed in $searchText subscriber below.
//    dataService.$allCoins
//      .sink { [weak self] returnedCoins in
//        self?.allCoins = returnedCoins
//      }
//      .store(in: &cancellables)
    
    // Updates allCoins
    $searchText
      .combineLatest(dataService.$allCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
  
  private func filterCoins(text: String, startingCoins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else {
      return startingCoins
    }
    
    let lowercasedText = text.lowercased()
    return startingCoins.filter { coin in
      return coin.name.lowercased().contains(lowercasedText) ||
        coin.symbol.lowercased().contains(lowercasedText) ||
        coin.id.lowercased().contains(lowercasedText)
    }
  }
}
