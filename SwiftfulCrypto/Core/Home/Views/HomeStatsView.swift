//
//  HomeStatsView.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/12/21.
//

import SwiftUI

struct HomeStatsView: View {
  
  // MARK: Properties
  @Binding var showPortfolio: Bool
  @EnvironmentObject private var vm: HomeViewModel
  
  // MARK: Body
  var body: some View {
    HStack {
      ForEach(vm.statistics) { stat in
        StatisticView(stat: stat)
          .frame(width: UIScreen.main.bounds.width / 3)
      }
    }
    .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
  }
}

// MARK: Preview
struct HomeStatsView_Previews: PreviewProvider {
  static var previews: some View {
    HomeStatsView(showPortfolio: .constant(false))
      .environmentObject(dev.homeVM)
  }
}
