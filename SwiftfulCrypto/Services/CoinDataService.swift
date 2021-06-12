//
//  CoinDataService.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/11/21.
//

import Foundation
import Combine

class CoinDataService {
  
  // MARK: Properties
  @Published var allCoins: [CoinModel] = []
  var coinSubscription: AnyCancellable?
  
  // MARK: Init
  init() {
    getCoins()
  }
  
  // MARK: Methods
  private func getCoins() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
      return
    }
    
    // Combine network logic
    coinSubscription = NetworkingManager.download(url: url)
      .decode(type: [CoinModel].self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
        self?.coinSubscription?.cancel()
      })
  }
}
