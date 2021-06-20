//
//  SettingsView.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/17/21.
//

import SwiftUI

struct SettingsView: View {

  // MARK: Properties
  let defaultURL = URL(string: "https://www.google.com")!
  let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
  let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
  let coingeckoURL = URL(string: "https://www.coingecko.com")!
  let personalURL = URL(string: "https://github.com/fjavaler")!
  
  // MARK: Body
  var body: some View {
    NavigationView {
      ZStack {
        // Background
        Color.theme.background
          .ignoresSafeArea()
        
        // Content layer
        List {
          swiftfulThinkingSection
            .listRowBackground(Color.theme.background.opacity(0.5))
          coinGeckoSection
            .listRowBackground(Color.theme.background.opacity(0.5))
          developerSection
            .listRowBackground(Color.theme.background.opacity(0.5))
          applicationSection
            .listRowBackground(Color.theme.background.opacity(0.5))
        }
      }
      .font(.headline)
      .accentColor(.blue)
      .listStyle(GroupedListStyle())
      .navigationTitle("Settings")
      .toolbar(content: {
        ToolbarItem(placement: .navigationBarLeading) {
          XMarkButton()
        }
      })
    }
  }
}

// MARK: Preview
struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}

extension SettingsView {
  
  private var swiftfulThinkingSection: some View {
    Section(header: Text("Swiftful Thinking")) {
      VStack {
        Image("logo")
          .resizable()
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM architecture, Combine, and CoreData!")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(Color.theme.accent)
      }
      .padding(.vertical)
      Link("Subscribe on YouTube 🥳", destination: youtubeURL)
      Link("Support his coffee addiction ☕️", destination: coffeeURL)
    }
  }
  
  private var coinGeckoSection: some View {
    Section(header: Text("CoinGecko")) {
      VStack {
        Image("coingecko")
          .resizable()
          .scaledToFit()
          .frame(height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("The cryptocurrency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(Color.theme.accent)
      }
      .padding(.vertical)
      Link("Visit CoinGecko 🦎", destination: coingeckoURL)
    }
  }
  
  private var developerSection: some View {
    Section(header: Text("Developer")) {
      VStack {
        Image("logo")
          .resizable()
          .scaledToFit()
          .frame(width: 100, height: 100)
          .clipShape(RoundedRectangle(cornerRadius: 20))
        Text("This app was developed by Frederick Javalera. It uses SwiftUI and was written 100% in Swift. The project benefits from multi-threading, publishers/subscribers, and data persistance.")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundColor(Color.theme.accent)
      }
      .padding(.vertical)
      Link("Visit My GitHub 😜", destination: personalURL)
    }
  }
  
  private var applicationSection: some View {
    Section(header: Text("Application")) {
      Link("Terms of Service", destination: defaultURL)
      Link("Privacy Policy", destination: defaultURL)
      Link("Company Website", destination: defaultURL)
      Link("Learn More", destination: defaultURL)
    }
  }
}
