//
//  ChampionDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import Foundation

public struct ChampionDTO: Codable, Hashable {
  let championImageUrl: String
  let kills: Double
  let deaths: Double
  let assists: Double
  let winRate: Double
  let wins: Int
  let losses: Int
}
