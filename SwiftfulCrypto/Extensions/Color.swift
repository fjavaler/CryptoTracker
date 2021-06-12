//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/11/21.
//

import SwiftUI

extension Color {
  static let theme = ColorTheme()
}

struct ColorTheme {
  let accent = Color("AccentColor")
  let background = Color("BackgroundColor")
  let green = Color("GreenColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
}

// Create alternate color themes
struct ColorTheme2 {
  let accent = Color("AccentColor")
  let background = Color("BackgroundColor")
  let green = Color("GreenColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
}
