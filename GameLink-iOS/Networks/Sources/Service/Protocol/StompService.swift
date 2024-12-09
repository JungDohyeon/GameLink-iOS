//
//  StompService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/6/24.
//

import Foundation

public protocol StompService {
  func connect(roomId: String, userId: String, userName: String)
  func send(nickname: String, body: String) async
  func disconnect() async
  
  func fetchPreviousMessages(page: Int, size: Int)
}
