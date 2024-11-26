//
//  SpeechBubbleType.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/26/24.
//

import SwiftUI

public enum SpeechBubbleType {
  case mine
  case others
  
  public var bubbleColor: Color {
    switch self {
    case .mine:
      return .glPrimary1
    case .others:
      return .glGray3
    }
  }
  
  public var textColor: Color {
    switch self {
    case .mine:
      return .black
    case .others:
      return .white
    }
  }
}
