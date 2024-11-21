//
//  RankEntity.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/22/24.
//

import Foundation

public struct RankEntity: Hashable {
  let type: RankType
  let tier: LOLTier
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
