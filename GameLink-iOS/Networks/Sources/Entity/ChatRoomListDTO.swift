//
//  ChatRoomListDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/16/24.
//

import Foundation

public struct ChatRoomListDTO: Codable, Hashable {
  public let content: [ChatroomDTO]
  public let hasNext: Bool
  public let totalPages: Int
  public let totalElements: Int
  public let page: Int
  public let size: Int
  public let first: Bool
  public let last: Bool
}
