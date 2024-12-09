//
//  ChatContentDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/29/24.
//

import Foundation

public struct ChatContentDTO: Codable, Hashable {
  let chatMessageId: String
  let userId: String
  let nickname: String
  let summonerIconUrl: String
  let content: String?
  let type: String
  let createdAt: String
  let fileName: String?
  let fileUrl: String?
  let fileType: String
  let timeNotation: Bool
  let continuous: Bool
  let dateChanged: Bool
  
  static func mock() -> ChatContentDTO {
    return ChatContentDTO(
      chatMessageId: UUID().uuidString,
      userId: UUID().uuidString,
      nickname: "테스트 유저",
      summonerIconUrl: "https://ddragon.leagueoflegends.com/cdn/14.22.1/img/profileicon/746.png",
      content: "테스트 메시지",
      type: "TALK",
      createdAt: ISO8601DateFormatter().string(from: Date()),
      fileName: nil,
      fileUrl: nil,
      fileType: "NONE",
      timeNotation: true,
      continuous: false,
      dateChanged: false
    )
  }
}
