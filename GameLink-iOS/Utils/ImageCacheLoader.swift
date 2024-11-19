//
//  ImageCacheLoader.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import SwiftUI

final class ImageCacheLoader: ObservableObject {
  @Published var image: UIImage?
  
  private var url: URL?
  
  init(url: URL?) {
    self.url = url
    
    Task {
      await loadImage()
    }
  }
  
  private func loadImage() async {
    guard let url = url else { return }
    
    // 캐시된 이미지가 있는 경우
    if let cachedImage = ImageCacheManager.shared.getImage(forKey: url.absoluteString) {
      DispatchQueue.main.async {
        self.image = cachedImage
      }
      return
    }
    
    // 캐시된 이미지가 없는 경우 네트워크에서 로드
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let downloadedImage = UIImage(data: data) {
        DispatchQueue.main.async {
          self.image = downloadedImage
        }
        ImageCacheManager.shared.setImage(downloadedImage, forKey: url.absoluteString)
      }
    } catch {
      print("Failed to load image from URL: \(error)")
    }
  }
}
