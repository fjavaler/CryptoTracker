//
//  LocalFileManager.swift
//  SwiftfulCrypto
//
//  Created by Fred Javalera on 6/12/21.
//

import Foundation
import SwiftUI

class LocalFileManager {
  
  // MARK: Properties
  static let instance = LocalFileManager() // Singleton instance
  
  // MARK: Init
  private init() {}
  
  // MARK: Methods
  
  /// We can't save an image directly to FileManager, therefore, we must send image's data to it instead.
  /// - Parameter image: The image to save.
  func saveImage(image: UIImage, imageName: String, folderName: String) {
    
    // Checks if save folder exists, if not, creates.
    createFolderIfNeeded(folderName: folderName)
    
    // Get path for image.
    guard let data = image.pngData(),
          let url = getURLForImage(imageName: imageName, folderName: folderName)
    else {return}
    
    // Saves image to path.
    do {
      try data.write(to: url)
    } catch let error {
      print("Error saving image. ImageName: \(imageName). \(error)")
    }
  }
  
  /// Gets an image by name.
  /// - Parameters:
  ///   - imageName: The name of the image.
  ///   - folderName: The folder that the image is stored in.
  /// - Returns: The image or nil.
  func getImage(imageName: String, folderName: String) -> UIImage? {
    guard let url = getURLForImage(imageName: imageName, folderName: folderName),
          FileManager.default.fileExists(atPath: url.path) else {
      return nil
    }
    return UIImage(contentsOfFile: url.path)
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
  
  /// Creates a folder if it is needed, else, does nothing.
  /// - Parameter folderName: The of the folder to check if exists, if not, creates.
  private func createFolderIfNeeded(folderName: String) {
    guard let url = getURLForFolder(folderName: folderName) else {return}
    
    if !FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
      } catch let error {
        print("Error creating directory. FolderName: \(folderName). \(error)")
      }
    }
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
