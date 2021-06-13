//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/12/21.
//

import Foundation

import Foundation
import Combine

class MarketDataService {
  
  // MARK: Properties
  @Published var marketData: MarketDataModel? = nil
  
  var marketDataSubscription: AnyCancellable?
  
  // MARK: Init
  init() {
    getData()
  }
  
  // MARK: Methods
  private func getData() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
      return
    }
    
    // Combine network logic
    marketDataSubscription = NetworkingManager.download(url: url)
      .decode(type: GlobalData.self, decoder: JSONDecoder())
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
        self?.marketData = returnedGlobalData.data
        self?.marketDataSubscription?.cancel()
      })
  }
}
