//
//  DefaultChatService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/27/24.
//

import Foundation

public typealias DefaultChatService = BaseService<ChatroomAPI>

extension DefaultChatService: ChatService {
  public func chatroomList(
    page: Int,
    size: Int,
    completion: @escaping (NetworkResult<ChatRoomListDTO>) -> Void
  ) {
    return requestObjectWithNetworkError(.chatroomList(page: page, size: size), completion: completion)
  }
  
  public func deletChatroom(roomId: Int, completion: @escaping (NetworkResult<Bool>) -> Void) {
    return requestObjectWithNetworkError(.deletChatroom(roomId: roomId), completion: completion)
  }
  
  public func checkUserEntered(roomId: Int, completion: @escaping (NetworkResult<Bool>) -> Void) {
    return requestObjectWithNetworkError(.checkUserEntered(roomId: roomId), completion: completion)
  }
  
  public func checkManager(roomId: Int, completion: @escaping (NetworkResult<Bool>) -> Void) {
    return requestObjectWithNetworkError(.checkManager(roomId: roomId), completion: completion)
  }
  
  public func createChatroom(roomName: String, maxUserCount: Int, completion: @escaping (NetworkResult<CreateChatRoomDTO>) -> Void) {
    return requestObjectWithNetworkError(.createChatroom(roomName: roomName, maxUserCount: maxUserCount), completion: completion)
  }
}
