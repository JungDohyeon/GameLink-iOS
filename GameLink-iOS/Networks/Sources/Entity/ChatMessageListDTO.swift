//
//  ChatMessageListDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/29/24.
//

import Foundation

public struct ChatMessageListDTO: Codable {
  let content: [ChatContentDTO]
  let hasNext: Bool
  let totalPages: Int
  let totalElements: Int
  let page: Int
  let size: Int
  let first: Bool
  let last: Bool
}
