//
//  ChatroomEntity.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/18/24.
//

import Foundation

public struct ChatroomEntity: Hashable {
  public let roomId: String
  public let roomName: String
  public let userCount: Int
  public let maxUserCount: Int
  public let leaderTierText: String
  public let leaderTier: LOLTier
  public let positions: [LOLPosition]
}
