//
//  CoinDetailDataService.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/15/21.
//

import Foundation
import Combine

class CoinDetailDataService {
  
  // MARK: Properties
  @Published var coinDetails: CoinDetailModel? = nil
  var coinDetailSubscription: AnyCancellable?
  let coin: CoinModel
  
  // MARK: Init
  init(coin: CoinModel) {
    self.coin = coin
    getCoinDetails()
  }
  
  // MARK: Methods
  func getCoinDetails() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
      return
    }
    
    // Combine network logic
    coinDetailSubscription = NetworkingManager.download(url: url)
      .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetails in
        self?.coinDetails = returnedCoinDetails
        self?.coinDetailSubscription?.cancel()
      })
  }
}
