//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/12/21.
//

import SwiftUI

class LocalFileManager {
  static let instance = LocalFileManager() // Singleton instance
  private init() {}
  
  // MARK: Methods
  
  
  /// We can't save an image directly to FileManager, therefore, we must send image's data to it instead.
  /// - Parameter image: The image to save.
  func saveImage(image: UIImage, imageName: String, folderName: String) {
    guard let data = image.pngData(),
          let url = getURLForImage(imageName: imageName, folderName: folderName)
    else {return}
    
    do {
      try data.write(to: url)
    } catch let error {
      print("Error saving image. \(error)")
    }
    
  }
  
  /// Gets the URL for the caches directory save folder.
  /// - Parameter folderName: The name of the folder.
  /// - Returns: Path for caches directory save folder, else, nil.
  private func getURLForFolder(folderName: String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
      return nil
    }
    
    return url.appendingPathComponent(folderName)
  }
  
  /// Gets the URL for the folder and appends the image name + ".png."
  /// - Parameters:
  ///   - imageName: The name of the image.
  ///   - folderName: The name of the folder.
  /// - Returns: Caches folder path + image name + .png
  func getURLForImage(imageName: String, folderName: String) -> URL? {
    guard let folderURL = getURLForFolder(folderName: folderName) else {
      return nil
    }
    
    return folderURL.appendingPathComponent(imageName + ".png")
  }
  
}
