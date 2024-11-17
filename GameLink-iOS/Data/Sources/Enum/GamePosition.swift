//
//  GamePosition.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/6/24.
//

import Foundation
import SwiftUI

public enum GamePosition {
  case lol(LOLPosition)
  
  public var positionImage: UIImage? {
    switch self {
    case let .lol(lolPosition):
      return lolPosition.positionImage
    }
  }
}

public enum LOLPosition {
  case top
  case jungle
  case mid
  case adcarry
  case supporter
  
  public var positionImage: UIImage {
    switch self {
    case .top:
      return .icTop
    case .jungle:
      return .icJungle
    case .mid:
      return .icMid
    case .adcarry:
      return .icBottom
    case .supporter:
      return .icSupport
    }
  }
}
