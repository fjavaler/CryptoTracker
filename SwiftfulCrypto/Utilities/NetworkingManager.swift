//
//  NetworkingManager.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/11/21.
//

import Foundation
import SwiftUI
import Combine

class NetworkingManager {
  
  /// Networking errors.
  enum NetworkingError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown
    
    var errorDescription: String? {
      switch self {
      case .badURLResponse(url: let url):
        return "[🔥] Bad response from URL: \(url)"
      case .unknown:
        return "[⚠️] Unknown error occured."
      }
    }
  }
  
  /// Generic Combine download logic.
  /// - Parameter url: Download URL.
  /// - Returns: A generic Publisher.
  static func download(url: URL) -> AnyPublisher<Data, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .tryMap({ try handleURLResponse(output: $0, url: url) })
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  /// Generic logic for handling URL responses from network requests.
  /// - Parameters:
  ///   - output: Returned output.
  ///   - url: The URL to retrieve the data from.
  /// - Throws: NetworkingError.badURLResponse
  /// - Returns: The successfully retrieved data.
  static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
    guard let response = output.response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
      throw NetworkingError.badURLResponse(url: url)
    }
    return output.data
  }
  
  /// Handles generic completion closure and checks for success.
  /// - Parameter completion: Completion handler.
  static func handleCompletion(completion: Subscribers.Completion<Error>) {
    switch completion {
    case .finished:
      break
    case .failure(let error):
      print(error.localizedDescription)
    }
  }
}
