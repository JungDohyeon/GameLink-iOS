//
//  GameType.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/19/24.
//

import Foundation
import SwiftUI

public enum GameType {
  case lol(LOLGameType)
}

public enum LOLGameType: CaseIterable {
  case soloRank
  case freeRank
  case normal
  
  public var korName: String {
    switch self {
      case .soloRank:
        return "개인/2인 랭크"
      case .freeRank:
        return "자유 랭크"
      case .normal:
        return "일반"
    }
  }
}
