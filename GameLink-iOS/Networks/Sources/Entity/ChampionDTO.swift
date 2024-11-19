//
//  ChampionDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import Foundation

public struct ChampionDTO: Codable, Hashable {
  let championImageUrl: String
  let kills: Int
  let deaths: Int
  let assists: Int
  let winRate: Int
  let wins: Int
  let losses: Int
}
