//
//  CreateChatRoomDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/16/24.
//

import Foundation

public struct CreateChatRoomDTO: Codable, Hashable {
  public let roomId: String
  public let roomName: String
  public let userCount: Int
  public let maxUserCount: Int
  public let status: String
}
