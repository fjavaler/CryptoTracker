//
//  ContentView.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/11/21.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: Properties
  
  
  // MARK: Body
    var body: some View {
      ZStack {
        Color.theme.background
          .ignoresSafeArea()
        
        VStack(spacing: 40) {
          Text("Accent Color")
            .foregroundColor(Color.theme.accent)
          
          Text("Secondary Text Color")
            .foregroundColor(Color.theme.secondaryText)
          
          Text("Red Color")
            .foregroundColor(Color.theme.red)
          
          Text("Green Color")
            .foregroundColor(Color.theme.green)
        }
        .font(.headline)
      }
    }
}

// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
        .preferredColorScheme(.dark)
    }
}
