//
//  MyChatroomDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/8/24.
//

import Foundation

public struct MyChatroomDTO: Codable, Hashable {
  let content: [MyChatroomContent]
  let hasNext: Bool
  let totalPages: Int
  let totalElements: Int
  let page: Int
  let size: Int
  let first: Bool
  let last: Bool
}

public struct MyChatroomContent: Codable, Hashable {
  let roomId: String
  let roomName: String
  let lastMessageTime: String
  let lastMessageContent: String?
  let users: [ChatUserDTO]
  let newMessageCount: Int
}

public struct ChatUserDTO: Codable, Hashable{
  let userId: String
  let nickname: String
  let summonerIconUrl: String
}
