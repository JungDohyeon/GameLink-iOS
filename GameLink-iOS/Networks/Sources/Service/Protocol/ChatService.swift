//
//  ChatService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/16/24.
//

import Foundation

public protocol ChatService {
  func chatroomList(
    page: Int,
    size: Int,
    completion: @escaping (NetworkResult<ChatRoomListDTO>) -> Void
  )
  
  func deletChatroom(
    roomId: String,
    completion: @escaping (NetworkResult<Bool>) -> Void
  )
  
  func selectPosition(
    roomId: String,
    position: LOLPosition,
    completion: @escaping (NetworkResult<VoidResponse>) -> Void
  )
  
  func checkUserEntered(
    roomId: String,
    completion: @escaping (NetworkResult<ChatRoomEnterDTO>) -> Void
  )
  
  func checkManager(
    roomId: String,
    completion: @escaping (NetworkResult<Bool>) -> Void
  )
  
  func createChatroom(
    roomName: String, 
    maxUserCount: Int,
    completion: @escaping (NetworkResult<CreateChatRoomDTO>) -> Void
  )
  
  func chatroomUserDetailInfo(
    roomId: String,
    completion: @escaping (NetworkResult<[ChatRoomUserListDetailDTO]>) -> Void
  )
}
