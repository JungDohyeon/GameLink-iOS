//
//  RiotAPI.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/25/24.
//

import Foundation
import Alamofire
import Moya

@frozen public enum RiotAPI {
  case checkAccount
  case changeAccount(gameName: String, tagLine: String)
  case checkRecord(start: Int)
  case refreshRecord
  case refreshAccount(userId: Int)
  case registerAccount(gameName: String, tagLine: String)
}

extension RiotAPI: BaseAPI {
  
  public static var apiType: APIType = .riot
  
  // MARK: - Header
  public var headers: [String: String]? {
    return HeaderType.jsonWithToken.value
  }
  
  // MARK: - Path
  public var path: String {
    switch self {
    case .checkAccount:
      return "account"
    case .changeAccount:
      return "account"
    case .checkRecord:
      return "account/match"
    case .refreshRecord:
      return "account/match/refresh"
    case .refreshAccount:
      return "account/refresh"
    case .registerAccount:
      return "account/register"
    }
  }
  
  // MARK: - Method
  public var method: Moya.Method {
    switch self {
    case .checkAccount:
      return .get
    case .changeAccount:
      return .patch
    case .checkRecord:
      return .get
    case .refreshRecord:
      return .patch
    case .refreshAccount:
      return .patch
    case .registerAccount:
      return .post
    }
  }
  
  // MARK: - Parameters
  private var bodyParameters: Parameters? {
    var params: Parameters = [:]
    
    switch self {
    case let .changeAccount(gameName, tagLine):
      params = [
        "gameName": gameName,
        "tagLine": tagLine
      ]
      
    case let .checkRecord(start):
      params = [
        "start": start
      ]
      
    case let .refreshAccount(userId):
      params = [
        "userId": userId
      ]
      
    case let .registerAccount(gameName, tagLine):
      params = [
        "gameName": gameName,
        "tagLine": tagLine
      ]
      
    default:
      break
    }
    
    return params
  }
  
  private var parameterEncoding: ParameterEncoding {
    switch self {
    case .checkAccount:
      return URLEncoding.default
    case .changeAccount:
      return JSONEncoding.default
    case .checkRecord:
      return URLEncoding.default
    case .refreshRecord:
      return JSONEncoding.default
    case .refreshAccount:
      return JSONEncoding.default
    case .registerAccount:
      return JSONEncoding.default
    }
  }
  
  public var task: Task {
    return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
  }
  
  public var validationType: ValidationType {
    return .none
  }
}
