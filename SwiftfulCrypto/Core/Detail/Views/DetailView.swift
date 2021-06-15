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
  @StateObject var vm: DetailViewModel
  private let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]
  private let spacing: CGFloat = 30
  
  // MARK: Init
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
  }
  
  // MARK: Body
  var body: some View {
    ScrollView {
      
      VStack {
        ChartView(coin: vm.coin)
          .padding(.vertical)
        
        VStack(spacing:20) {
          
          overviewTitle
          
          Divider()
          
          overviewGrid
          
          additionalTitle
          
          Divider()
          
          additionalGrid
          
        }
        .padding()
        
      }
      
    }
    .navigationTitle(vm.coin.name)
    .toolbar(content: {
      ToolbarItem(placement: .navigationBarTrailing) {
        navigationBarTrailingItems
      }
    })
  }
}

// MARK: Preview
struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      DetailView(coin: dev.coin)
    }
  }
}

extension DetailView {
  private var overviewTitle: some View {
    Text("Overview")
      .font(.title)
      .bold()
      .foregroundColor(Color.theme.accent)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var additionalTitle: some View {
    Text("Additional Details")
      .font(.title)
      .bold()
      .foregroundColor(Color.theme.accent)
      .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  private var overviewGrid: some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: spacing,
      pinnedViews: [],
      content: {
        ForEach(vm.overviewStatistics) {stat in
          StatisticView(stat: stat)
        }
    })
  }
  
  private var additionalGrid: some View {
    LazyVGrid(
      columns: columns,
      alignment: .leading,
      spacing: spacing,
      pinnedViews: [],
      content: {
        ForEach(vm.additionalStatistics) {stat in
          StatisticView(stat: stat)
        }
    })
  }
  
  private var navigationBarTrailingItems: some View {
    HStack {
      Text(vm.coin.symbol.uppercased())
        .font(.headline)
        .foregroundColor(Color.theme.secondaryText)
      CoinImageView(coin: vm.coin)
        .frame(width: 25, height: 25)
    }
  }
}
