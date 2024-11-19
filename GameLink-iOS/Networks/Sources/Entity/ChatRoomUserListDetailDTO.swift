//
//  ChatRoomUserListDetailDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import Foundation

public struct ChatRoomUserListDetailDTO: Codable, Hashable {
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
  let position: String
  let gameInfo: GameInfoDTO
}
