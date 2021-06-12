//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/12/21.
//

import SwiftUI
import Combine

class CoinImageService {
  
  @Published var image: UIImage? = nil
  private var imageSubscription: AnyCancellable?
  private let coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoinImage()
  }
  
  private func getCoinImage() {
    print("Downloading image now")
    guard let url = URL(string: coin.image) else { return }
    
    // Combine network logic
    imageSubscription = NetworkingManager.download(url: url)
      .tryMap({ data -> UIImage? in
        return UIImage(data: data)
      })
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
        self?.image = returnedImage
        self?.imageSubscription?.cancel()
      })
  }
}
