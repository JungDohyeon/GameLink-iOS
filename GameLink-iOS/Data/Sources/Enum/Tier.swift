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

public enum LOLTier: String {
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
    return UIImage(named: "ic_\(self.rawValue)") ?? UIImage()
  }
}

extension LOLTier {
  private static let tierMapping: [String: LOLTier] = [
    "B": .bronze,
    "S": .silver,
    "G": .gold,
    "P": .platinum,
    "E": .emerald,
    "D": .diamond,
    "M": .master,
    "GM": .grandmaster,
    "C": .challenger
  ]

  public static func stringToLOLTier(tier: String) -> LOLTier {
    return tierMapping[tier] ?? .unrank
  }
}
