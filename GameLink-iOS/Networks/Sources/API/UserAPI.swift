//
//  UserAPI.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Foundation
import Alamofire
import Moya

@frozen public enum UserAPI {
  case kakaoSignIn(accessToken: String, deviceId: String)
  case reissue(refreshToken: String)
}

extension UserAPI: BaseAPI {
  
  public static var apiType: APIType = .user
  
  // MARK: - Header
  public var headers: [String: String]? {
    switch self {
    case .kakaoSignIn:
      return HeaderType.json.value
    case .reissue:
      return HeaderType.jsonWithToken.value
    }
  }
  
  // MARK: - Path
  public var path: String {
    switch self {
    case .kakaoSignIn:
      return "oauth/kakao/login"
    case .reissue:
      return "reissue"
    }
  }
  
  // MARK: - Method
  public var method: Moya.Method {
    switch self {
    case .kakaoSignIn:
      return .post
    case .reissue:
      return .post
    }
  }
  
  // MARK: - Parameters
  private var bodyParameters: Parameters? {
    var params: Parameters = [:]
    
    switch self {
    case let .kakaoSignIn(accessToken, deviceId):
      params = [
        "accessToken": accessToken,
        "deviceId": deviceId
      ]
      
    case let .reissue(refreshToken):
      params = [
        "refreshToken": refreshToken
      ]
    }
    
    return params
  }
  
  private var parameterEncoding: ParameterEncoding {
    switch self {
    default:
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
