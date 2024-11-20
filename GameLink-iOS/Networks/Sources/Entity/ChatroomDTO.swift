//
//  ChatroomDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/18/24.
//

import Foundation

public struct ChatroomDTO: Codable, Hashable {
  public let roomId: String
  public let roomName: String
  public let userCount: Int
  public let maxUserCount: Int
  public let leaderTier: String
  public let positions: [String]
}
