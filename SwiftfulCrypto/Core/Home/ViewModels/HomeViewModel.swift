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
  @Published var isLoading = false
  @Published var sortOption: SortOption = .holdings
  
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  private var cancellables = Set<AnyCancellable>()
  
  enum SortOption {
    case rank, rankReversed, holdings, holdingsReversed, price, priceReversed
  }
  
  // MARK: Init
  init() {
    addSubscribers()
  }
  
  // MARK: Methods
  func addSubscribers() {
    
    // Updates allCoins.
    $searchText
      .combineLatest(coinDataService.$allCoins, $sortOption)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterAndSortCoins)
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
    
    // Updates portfolioCoins
    $allCoins
      .combineLatest(portfolioDataService.$savedEntities)
      .map(mapAllCoinsToPortfolioCoins)
      .sink { [weak self] returnedCoins in
        guard let self = self else { return }
        self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
      }
      .store(in: &cancellables)
    
    // Updates marketData.
    marketDataService.$marketData
      .combineLatest($portfolioCoins)
      .map(mapGlobalMarketData)
      .sink { [weak self] returnedStats in
        self?.statistics = returnedStats
        self?.isLoading = false
      }
      .store(in: &cancellables)
  }
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  func reloadData() {
    isLoading = true
    coinDataService.getCoins()
    marketDataService.getData()
    HapticManager.notification(type: .success)
  }
  
  private func filterAndSortCoins(text: String, startingCoins: [CoinModel], sort: SortOption) -> [CoinModel] {
    var updatedCoins = filterCoins(text: text, startingCoins: startingCoins)
    sortCoins(sort: sort, coins: &updatedCoins)
    return updatedCoins
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
  
  private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
    switch sort {
    case .rank, .holdings:
      coins.sort(by: { $0.rank < $1.rank })
      // Long form
//      return coins.sorted { coin1, coin2 in
//        return coin1.rank < coin2.rank
//      }
    case .rankReversed, .holdingsReversed:
      coins.sort(by: { $0.rank > $1.rank })
    case .price:
      coins.sort(by: { $0.currentPrice < $1.currentPrice })
    case .priceReversed:
      coins.sort(by: { $0.currentPrice > $1.currentPrice })
    }
  }
  
  private func sortPortfolioCoinsIfNeeded(coins: [CoinModel]) -> [CoinModel] {
    // Will only sort by holdings or reversedHoldings if needed.
    switch sortOption {
    case .holdings:
      return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
    case .holdingsReversed:
      return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
    default:
      return coins
    }
  }
  
  private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioEntities: [PortfolioEntity]) -> [CoinModel] {
    allCoins.compactMap { coin -> CoinModel? in
      guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
        return nil
      }
      return coin.updateHoldings(amount: entity.amount)
    }
  }
  
  private func mapGlobalMarketData(marketDataModel: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatisticModel] {
    var stats: [StatisticModel] = []
    
    guard let data = marketDataModel else {
      return stats
    }
    
    let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
    
    let volume = StatisticModel(title: "24h Volume", value: data.volume)
    
    let bitcoinDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance)
    
    // Long form
    //    let portfolioValue = portfolioCoins.map { coin -> Double in
    //      return coin.currentHoldingsValue
    //    }
    
    // Short form
    let portfolioValue = portfolioCoins
      .map({ $0.currentHoldingsValue})
      // adds all of the values in the currentHoldingsValue array up
      .reduce(0, +)
    
    let previousValue = portfolioCoins
      .map { coin -> Double in
        let currentValue = coin.currentHoldingsValue
        let percentChange = coin.priceChangePercentage24H ?? 0 / 100
        let previousValue = currentValue / (1 + percentChange)
        return previousValue
      }
      .reduce(0, +) //<- sums all values
    
    let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
    
    let portfolio = StatisticModel(
      title: "Portfolio Value",
      value: portfolioValue.asCurrencyWith2Decimals(),
      percentageChange: percentageChange)
    
    stats.append(contentsOf: [
      marketCap,
      volume,
      bitcoinDominance,
      portfolio
    ])
    
    return stats
  }
}
