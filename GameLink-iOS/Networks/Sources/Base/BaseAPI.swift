//
//  BaseAPI.swift
//  Networks
//
//  Created by 정도현 on 9/21/24.
//

import Alamofire
import Moya
import Foundation

public enum APIType {
  // MARK: API TYPES
  case user
  case chatroom
  case riot
}

public protocol BaseAPI: TargetType {
  static var apiType: APIType { get set }
}

extension BaseAPI {
  public var baseURL: URL {
    var base = Config.baseURL
    
    switch Self.apiType {
      // MARK: API TYPE ADDRESS
    case .user:
      base += "/user"
      
    case .chatroom:
      base += ""
      
    case .riot:
      base += "/riot/lol"
    }
    
    guard let url = URL(string: base) else {
      fatalError("baseURL could not be configured")
    }
    
    return url
  }
  
  public var headers: [String: String]? {
    return HeaderType.jsonWithToken.value
  }
  
  public var validationType: ValidationType {
    return .customCodes(Array(200..<600).filter { $0 != 401 })
  }
}

public enum HeaderType {
  case json
  case jsonWithToken
  case multipartWithToken
  
  public var value: [String: String] {
    switch self {
    case .json:
      return ["Content-Type": "application/json"]
      
    case .jsonWithToken:
      if let accessToken = UserDefaultsList.Auth.accessToken {
        return [
          "Content-Type": "application/json",
          "Authorization": "Bearer \(accessToken)"
        ]
      } else {
        return [
          "Content-Type": "application/json"
        ]
      }
      
    case .multipartWithToken:
      if let accessToken = UserDefaultsList.Auth.accessToken {
        return [
          "Content-Type": "application/json",
          "Authorization": "Bearer \(accessToken)"
        ]
      } else {
        return [
          "Content-Type": "application/json"
        ]
      }
    }
  }
}
