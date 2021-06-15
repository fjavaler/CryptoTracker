//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/14/21.
//

import Foundation
import SwiftUI

class HapticManager {
  static private let generator = UINotificationFeedbackGenerator()
  
  static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    generator.notificationOccurred(type)
  }
}
