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

public enum LOLPosition: String, CaseIterable {
  case top = "TOP"
  case jungle = "JUNGLE"
  case mid = "MID"
  case adcarry = "ACD"
  case supporter = "SUPPORT"
  case any = "ANY"
  
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
    case .any:
      return UIImage()
    }
  }
  
  public var korName: String {
    switch self {
    case .top:
      return "탑"
    case .jungle:
      return "정글"
    case .mid:
      return "미드"
    case .adcarry:
      return "원딜"
    case .supporter:
      return "서포터"
    case .any:
      return "상관없음"
    }
  }
}
