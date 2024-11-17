//
//  Tier.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/6/24.
//

import Foundation
import SwiftUI

public enum Tier {
  case lol(LOLTier)
  
  public var tierImage: UIImage? {
    switch self {
    case let .lol(tier):
      return tier.tierImage
    }
  }
}

public enum LOLTier {
  case unrank
  case bronze
  case silver
  case gold
  case platinum
  case emerald
  case diamond
  case master
  case grandmaster
  case challenger
  
  public var tierImage: UIImage {
    switch self {
    case .unrank:
      return .icUnrank
    case .bronze:
      return .icBronze
    case .silver:
      return .icSilver
    case .gold:
      return .icGold
    case .platinum:
      return .icPlatinum
    case .emerald:
      return .icEmerald
    case .diamond:
      return .icDiamond
    case .master:
      return .icMaster
    case .grandmaster:
      return .icGrandMaster
    case .challenger:
      return .icChallenger
    }
  }
}
