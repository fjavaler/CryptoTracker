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
  @State private var showLaunchView: Bool = true
  
  // MARK: Init
  init() {
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
  }
  
  // MARK: Body
  var body: some Scene {
    WindowGroup {
      ZStack {
        NavigationView {
          HomeView()
            .navigationBarHidden(true)
        }
        .environmentObject(vm)
        
        ZStack {
          if showLaunchView {
            LaunchView(showLaunchView: $showLaunchView)
              .transition(.move(edge: .leading))
          }
        }
        .zIndex(2.0)
      }
    }
  }
}
