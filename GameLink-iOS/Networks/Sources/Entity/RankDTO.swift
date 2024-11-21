//
//  RankDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/21/24.
//

import Foundation

public struct RankDTO: Codable, Hashable {
  let rankImageUrl: String
  let tier: String
  let rank: String
  let leaguePoints: Int
  let wins: Int
  let losses: Int
  let winRate: Double
  let kda: Double
  let avgKills: Double
  let avgDeaths: Double
  let avgAssists: Double
  let avgCs: Double
  let best3champions: [ChampionDTO]
  let veteran: Bool
  let inactive: Bool
  let freshBlood: Bool
  let hotStreak: Bool
}

public extension RankDTO {
  static func toRankEntity(type: RankType, data: RankDTO) -> RankEntity {
    return RankEntity(
      type: type,
      tier: LOLTier.stringToLOLTier(tier: data.tier),
      rank: data.rank,
      leaguePoints: data.leaguePoints,
      wins: data.wins,
      losses: data.losses,
      winRate: data.winRate,
      kda: data.kda,
      avgKills: data.avgKills,
      avgDeaths: data.avgDeaths,
      avgAssists: data.avgAssists,
      avgCs: data.avgCs,
      best3champions: data.best3champions,
      veteran: data.veteran,
      inactive: data.inactive,
      freshBlood: data.freshBlood,
      hotStreak: data.hotStreak
    )
  }
}
