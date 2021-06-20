//
//  CoinRowView.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/11/21.
//

import SwiftUI

struct CoinRowView: View {
  
  // MARK: Properties
  let coin: CoinModel
  let showHoldingsColumn: Bool
  
  // MARK: Body
  var body: some View {
    HStack(spacing: 0) {
      leftColumn
      Spacer()
      if showHoldingsColumn {
        centerColumn
      }
      rightColumn
    }
    .font(.subheadline)
    .background(Color.theme.background.opacity(0.001))
  }
}

// MARK: Preview
struct CoinRowView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      CoinRowView(coin: dev.coin, showHoldingsColumn: true)
        .previewLayout(.sizeThatFits)
      
      CoinRowView(coin: dev.coin, showHoldingsColumn: true)
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)
    }
  }
}

extension CoinRowView {
  private var leftColumn: some View {
    HStack(spacing:0) {
    Text("\(coin.rank)")
      .font(.caption)
      .foregroundColor(Color.theme.secondaryText)
      .frame(minWidth: 30)
    CoinImageView(coin: coin)
      .frame(width: 30, height: 30)
    Text(coin.symbol.uppercased())
      .font(.headline)
      .padding(.leading, 6)
      .foregroundColor(Color.theme.accent)
    }
  }
  
  private var centerColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
      Text((coin.currentHoldings ?? 0).asNumberString())
    }
    .foregroundColor(Color.theme.accent)
  }
  
  private var rightColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentPrice.asCurrencyWith6Decimals())
        .bold()
        .foregroundColor(Color.theme.accent)
      Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
        .foregroundColor(
          (coin.priceChangePercentage24H ?? 0 >= 0) ?
            Color.theme.green :
            Color.theme.red
        )
    }
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}
