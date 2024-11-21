//
//  LOLMatchDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/22/24.
//

import Foundation

public struct LOLMatchDTO: Codable, Hashable {
  let matchId: String
  let matchType: String
  let championName: String
  let doubleKills: Int
  let firstBloodKill: Bool
  let teamPosition: String
  let pentaKills: Int
  let assists: Int
  let deaths: Int
  let kills: Int
  let kda: Double
  let firstBloodAssist: Bool
  let firstTowerAssist: Bool
  let firstTowerKill: Bool
  let goldPerMinute: Int
  let gameEndedInEarlySurrender: Bool
  let gameEndedInSurrender: Bool
  let timePlayed: Int
  let totalMinionsKilled: Int
  let win: Bool
  let soloKills: Int
  let legendaryCount: Int
  let damagePerMinute: Int
  let dragonTakedowns: Int
  let epicMonsterSteals: Int
  let baronTakedowns: Int
  let voidMonsterKill: Int
  let perfectDragonSoulsTaken: Int
  let elderDragonMultikills: Int
  let killParticipation: Int
}
