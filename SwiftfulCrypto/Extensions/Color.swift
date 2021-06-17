//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/11/21.
//

import SwiftUI

extension Color {
  static let theme = ColorTheme()
  static let launch = LaunchTheme()
}

struct ColorTheme {
  let accent = Color("AccentColor")
  let background = Color("BackgroundColor")
  let green = Color("GreenColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {
  let accent = Color("LaunchAccentColor")
  let background = Color("LaunchBackgroundColor")
}

// Create alternate color themes
struct ColorTheme2 {
  let accent = Color("AccentColor")
  let background = Color("BackgroundColor")
  let green = Color("GreenColor")
  let red = Color("RedColor")
  let secondaryText = Color("SecondaryTextColor")
}
