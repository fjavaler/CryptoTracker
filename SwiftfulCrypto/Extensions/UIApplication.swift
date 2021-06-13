//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/12/21.
//

import Foundation
import SwiftUI

extension UIApplication {
  
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
  
}
