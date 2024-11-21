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

public enum LOLTier: String, CaseIterable {
  case unrank
  case bronze
  case silver
  case gold
  case platinum
  case emerald
  case diamond
  case master
  case grandmaster = "grand_master"
  case challenger
  
  public var tierImage: UIImage {
    return UIImage(named: "ic_\(self.rawValue)") ?? UIImage()
  }
  
  public var korName: String {
    switch self {
    case .unrank:
      return "언랭크"
    case .bronze:
      return "브론즈"
    case .silver:
      return "실버"
    case .gold:
      return "골드"
    case .platinum:
      return "플래티넘"
    case .emerald:
      return "에메랄드"
    case .diamond:
      return "다이아몬드"
    case .master:
      return "마스터"
    case .grandmaster:
      return "그랜드마스터"
    case .challenger:
      return "챌린저"
    }
  }
  
  public var engName: String {
    switch self {
    case .grandmaster:
      return "GRANDMASTER"
      
    default:
      return self.rawValue.uppercased()
    }
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
    "C": .challenger,
    "BRONZE": .bronze,
    "SILVER": .silver,
    "GOLD": .gold,
    "PLATINUM":.platinum,
    "EMERALD": .emerald,
    "DIAMOND": .diamond,
    "MASTER": .master,
    "GRANDMASTER": .grandmaster,
    "CHALLENGER": .challenger,
    "UNRANKED": .unrank
  ]

  public static func stringToLOLTier(tier: String) -> LOLTier {
    return tierMapping[tier] ?? .unrank
  }
}
