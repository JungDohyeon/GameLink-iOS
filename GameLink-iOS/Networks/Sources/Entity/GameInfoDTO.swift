//
//  GameInfoDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import Foundation

public struct GameInfoDTO: Codable, Hashable {
  let gameType: String
  let rankImageUrl: String
  let tier: String
  let rank: String
  let leaguePoints: Int
  let wins: Int
  let losses: Int
  let winRate: Int
  let kda: Int
  let avgKills: Int
  let avgDeaths: Int
  let avgAssists: Int
  let avgCs: Int
  let best3Champions: [ChampionDTO]
  let veteran: Bool
  let inactive: Bool
  let freshBlood: Bool
  let hotStreak: Bool
}
