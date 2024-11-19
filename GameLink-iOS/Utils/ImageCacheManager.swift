//
//  ImageCacheManager.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import UIKit

class ImageCacheManager {
  static let shared = ImageCacheManager()
  
  private let cache = NSCache<NSString, UIImage>()
  
  private init() {}
  
  func getImage(forKey key: String) -> UIImage? {
    return cache.object(forKey: key as NSString)
  }
  
  func setImage(_ image: UIImage, forKey key: String) {
    cache.setObject(image, forKey: key as NSString)
  }
}
