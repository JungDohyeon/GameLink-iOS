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
  let profileImageUrl: [ProfileImage]
  let email: String
  let puuid: String
  let summonerId: String
  let summonerName: String
  let summonerTag: String
  let summonerIconUrl: String
  let revisionDate: String
  let summonerLevel: Int
  let soloRank: Rank
  let teamRank: Rank
  
  struct ProfileImage: Codable {
    let id: String
    let url: String
    let originalName: String
    let mimeType: String
  }
  
  struct Rank: Codable {
    let rankImageUrl: String
    let tier: String
    let rank: String
    let leaguePoints: Int
    let wins: Int
    let losses: Int
    let veteran: Bool
    let inactive: Bool
    let freshBlood: Bool
    let hotStreak: Bool
  }
}
