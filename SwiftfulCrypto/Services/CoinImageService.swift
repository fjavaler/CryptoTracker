//
//  CoinImageService.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/12/21.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
  
  // MARK: Properties
  @Published var image: UIImage? = nil
  private var imageSubscription: AnyCancellable?
  private let coin: CoinModel
  private let fileManager = LocalFileManager.instance
  private let folderName = "coin_images"
  private let imageName: String
  
  // MARK: Init
  init(coin: CoinModel) {
    self.coin = coin
    self.imageName = coin.id
    getCoinImage()
  }
  
  // MARK: Methods
  
  /// Attempts to get the coin image first from file manager. If not present, downloads it.
  private func getCoinImage() {
    if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
      self.image = savedImage
    } else {
      downloadCoinImage()
    }
  }
  
  /// Downloads the coin image via a network call.
  private func downloadCoinImage() {
    guard let url = URL(string: coin.image) else { return }

    // Combine network logic
    imageSubscription = NetworkingManager.download(url: url)
      .tryMap({ data -> UIImage? in
        return UIImage(data: data)
      })
      .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
        guard let self = self,
              let downloadedImage = returnedImage else {
          return
        }
        self.image = downloadedImage
        self.imageSubscription?.cancel()
        self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
      })
  }
}
