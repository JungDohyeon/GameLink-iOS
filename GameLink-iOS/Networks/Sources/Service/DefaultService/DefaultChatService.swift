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
  
  public func deletChatroom(
    roomId: String,
    completion: @escaping (NetworkResult<Bool>) -> Void
  ) {
    return requestObjectWithNetworkError(.deletChatroom(roomId: roomId), completion: completion)
  }
  
  public func selectPosition(
    roomId: String,
    position: LOLPosition,
    completion: @escaping (NetworkResult<VoidResponse>) -> Void
  ) {
    return requestObjectWithNetworkError(.selectPosition(roomId: roomId, myPosition: position.rawValue), completion: completion)
  }
  
  public func checkUserEntered(
    roomId: String,
    completion: @escaping (NetworkResult<ChatRoomEnterDTO>) -> Void
  ) {
    return requestObjectWithNetworkError(.checkUserEntered(roomId: roomId), completion: completion)
  }
  
  public func checkManager(
    roomId: String,
    completion: @escaping (NetworkResult<Bool>) -> Void
  ) {
    return requestObjectWithNetworkError(.checkManager(roomId: roomId), completion: completion)
  }
  
  public func createChatroom(
    roomName: String,
    maxUserCount: Int,
    completion: @escaping (NetworkResult<CreateChatRoomDTO>) -> Void
  ) {
    return requestObjectWithNetworkError(.createChatroom(roomName: roomName, maxUserCount: maxUserCount), completion: completion)
  }
  
  public func chatroomUserDetailInfo(
    roomId: String,
    completion: @escaping (NetworkResult<[ChatRoomUserListDetailDTO]>) -> Void
  ) {
    return requestObjectWithNetworkError(.chatroomUserDetailInfo(roomId: roomId), completion: completion)
  }
}
