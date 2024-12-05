//
//  ChatContentDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/29/24.
//

import Foundation

public struct ChatContentDTO: Codable {
  let chatMessgaeId: String
  let userId: String
  let nickname: String
  let summonerIconUrl: String
  let content: String
  let type: String
  let createdAt: String
  let fileName: String
  let fileUrl: String
  let fileType: String
  let timeNotation: Bool
  let continuous: Bool
  let dateChanged: Bool
}
