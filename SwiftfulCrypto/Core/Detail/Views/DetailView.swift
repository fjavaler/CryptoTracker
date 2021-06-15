//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/14/21.
//

import SwiftUI

struct DetailLoadingView: View {
  // MARK: Properties
  @Binding var coin: CoinModel?
  
  // MARK: Body
  var body: some View {
    ZStack {
      if let coin = coin {
        DetailView(coin: coin)
      }
    }
  }
}

struct DetailView: View {
  
  // MARK: Properties
  let coin: CoinModel
  
  // MARK: Init
  init(coin: CoinModel) {
    self.coin = coin
    print("Initializing Detail View for \(coin.name)")
  }
  
  // MARK: Body
  var body: some View {
    Text(coin.name)
  }
}

// MARK: Preview
struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(coin: dev.coin)
  }
}
