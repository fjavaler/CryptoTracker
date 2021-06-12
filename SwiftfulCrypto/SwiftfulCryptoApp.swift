//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/11/21.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
  
  // MARK: Properties
  @StateObject private var vm = HomeViewModel()
  
  // MARK: Body
  var body: some Scene {
    WindowGroup {
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      }
      .environmentObject(vm)
    }
  }
}
