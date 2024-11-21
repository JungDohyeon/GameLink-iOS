//
//  RiotAccountDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/27/24.
//

import Foundation

public struct RiotAccountDTO: Codable {
  let userId: String
  let nickname: String
  let backgroundImageUrl: String
  let email: String
  let puuid: String
  let summonerId: String
  let summonerName: String
  let summonerTag: String
  let summonerIconUrl: String
  let revisionDate: String
  let summonerLevel: Int
  let total: RankDTO
  let soloRank: RankDTO
  let teamRank: RankDTO
}
