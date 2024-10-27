//
//  ChatService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/16/24.
//

import Foundation
import Alamofire
import Moya

public typealias DefaultChatService = BaseService<ChatroomAPI>

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

extension DefaultChatService: ChatService {
  public func chatroomList(completion: @escaping (NetworkResult<[ChatRoomListDTO]>) -> Void) {
    return requestObjectWithNetworkError(.chatroomList, completion: completion)
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
