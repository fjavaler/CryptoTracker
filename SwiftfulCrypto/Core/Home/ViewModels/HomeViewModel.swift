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
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  private let dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()
  
  // MARK: Init
  init() {
    addSubscribers()
  }
  
  // MARK: Methods
  func addSubscribers() {
    dataService.$allCoins
      .sink { [weak self] returnedCoins in
        self?.allCoins = returnedCoins
      }
      .store(in: &cancellables)
  }
}
