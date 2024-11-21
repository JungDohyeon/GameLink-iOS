//
//  CachedImageView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import SwiftUI

struct CachedImageView: View {
  @StateObject private var loader: ImageCacheLoader
  
  init(url: URL?) {
    _loader = StateObject(wrappedValue: ImageCacheLoader(url: url))
  }
  
  var body: some View {
    Group {
      if let image = loader.image {
        Image(uiImage: image)
          .resizable()
      } else {
        ProgressView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}
