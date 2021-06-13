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
  @Published var statistics: [StatisticModel] = []
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  @Published var searchText: String = ""
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
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
    
    // Updates allCoins.
    $searchText
      .combineLatest(coinDataService.$allCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
    
    // Updates marketData.
    marketDataService.$marketData
      .map(mapGlobalMarketData)
      .sink { [weak self] returnedStats in
        self?.statistics = returnedStats
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
  
  private func mapGlobalMarketData(marketDataModel: MarketDataModel?) -> [StatisticModel] {
    var stats: [StatisticModel] = []
    
    guard let data = marketDataModel else {
      return stats
    }
    
    let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    
    let volume = StatisticModel(title: "24h Volume", value: data.volume)
    
    let bitcoinDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
    
    let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
    
    stats.append(contentsOf: [
      marketCap,
      volume,
      bitcoinDominance,
      portfolio
    ])
    
    return stats
  }
}
