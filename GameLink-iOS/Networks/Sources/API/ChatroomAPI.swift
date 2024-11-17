//
//  ChatroomAPI.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/16/24.
//

import Foundation
import Alamofire
import Moya

@frozen public enum ChatroomAPI {
  case chatroomList(page: Int, size: Int)
  case deletChatroom(roomId: Int)
  case checkUserEntered(roomId: Int)
  case checkManager(roomId: Int)
  case createChatroom(roomName: String, maxUserCount: Int)
}

extension ChatroomAPI: BaseAPI {
  
  public static var apiType: APIType = .chatroom
  
  // MARK: - Header
  public var headers: [String: String]? {
    switch self {
    default:
      return HeaderType.jsonWithToken.value
    }
  }
  
  // MARK: - Path
  public var path: String {
    var endPath = "chatroom"
    
    switch self {
    case .chatroomList:
      break
    case .deletChatroom:
      break
    case let .checkUserEntered(roomId):
      endPath += "checkUserCnt/\(roomId)"
    case let .checkManager(roomId):
      endPath += "confirm/manager/\(roomId)"
    case .createChatroom:
      endPath += "create"
    }
    
    return endPath
  }
  
  // MARK: - Method
  public var method: Moya.Method {
    switch self {
    case .chatroomList:
      return .get
    case .deletChatroom:
      return .delete
    case .checkUserEntered:
      return .get
    case .checkManager:
      return .get
    case .createChatroom:
      return .post
    }
  }
  
  // MARK: - Parameters
  private var bodyParameters: Parameters? {
    var params: Parameters = [:]
    
    switch self {
      
    case let .chatroomList(page, size):
      params["page"] = page
      params["size"] = size
      
    case let .deletChatroom(roomId):
      params["roomId"] = roomId

    case let .createChatroom(roomName, maxUserCount):
      params["rooomName"] = roomName
      params["maxUserCount"] = maxUserCount

    default:
      break
    }
    
    return params
  }
  
  private var parameterEncoding: ParameterEncoding {
    switch self {
    case .chatroomList:
      return URLEncoding.default
    case .deletChatroom:
      return JSONEncoding.default
    case .checkUserEntered:
      return URLEncoding.default
    case .checkManager:
      return URLEncoding.default
    case .createChatroom:
      return JSONEncoding.default
    }
  }
  
  public var task: Task {
    switch self {
    default:
        return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
    }
  }
  
  public var validationType: ValidationType {
    return .none
  }
}
