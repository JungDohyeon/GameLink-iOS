//
//  ChatService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/16/24.
//

import Foundation

public protocol ChatService {
  func chatroomList(
    completion: @escaping (NetworkResult<[ChatRoomListDTO]>) -> Void
  )
  
  func deletChatroom(
    roomId: Int,
    completion: @escaping (NetworkResult<Bool>) -> Void
  )
  
  func checkUserEntered(
    roomId: Int,
    completion: @escaping (NetworkResult<Bool>) -> Void
  )
  
  func checkManager(
    roomId: Int,
    completion: @escaping (NetworkResult<Bool>) -> Void
  )
  
  func createChatroom(
    roomName: String, 
    maxUserCount: Int,
    completion: @escaping (NetworkResult<CreateChatRoomDTO>) -> Void
  )
}
