//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Frederick Javalera on 6/15/21.
//

import Foundation

extension String {
  var removingHTMLOccurances: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
}
