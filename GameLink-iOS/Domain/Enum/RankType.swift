//
//  RankType.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/22/24.
//

import Foundation

public enum RankType {
  case solo
  case team
  
  public var korTitle: String {
    switch self {
    case .solo:
      return "개인/2인 랭크"
    case .team:
      return "팀 랭크"
    }
  }
}
