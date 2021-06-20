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
  let accent = Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1))
  let background = Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1))
  let green = Color(#colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))
  let red = Color(#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1))
  let secondaryText = Color(#colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
}
