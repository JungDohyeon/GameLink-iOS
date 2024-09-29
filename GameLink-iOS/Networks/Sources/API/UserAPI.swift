//
//  UserAPI.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Foundation
import Alamofire
import Moya

public enum UserAPI {
  case kakaoSignIn(data: OAuthRequestDTO)
}

extension UserAPI: BaseAPI {
  
  public static var apiType: APIType = .user
  
  // MARK: - Header
  public var headers: [String: String]? {
    switch self {
    case .kakaoSignIn:
      return HeaderType.json.value
    }
  }
  
  // MARK: - Path
  public var path: String {
    switch self {
    case .kakaoSignIn:
      return "oauth/kakao/login"
    }
  }
  
  // MARK: - Method
  public var method: Moya.Method {
    switch self {
    case .kakaoSignIn:
      return .post
    }
  }
  
  // MARK: - Parameters
  private var bodyParameters: Parameters? {
    var params: Parameters = [:]
    
    switch self {
    case let .kakaoSignIn(data):
      
      let deviceInfo: Parameters = [
        "uniqueId": data.deviceInfo.uniqueId,
        "model": data.deviceInfo.model,
        "deviceId": data.deviceInfo.deviceId,
        "deviceName": data.deviceInfo.deviceName
      ]
      
      let kakaoInfo: Parameters = [
        "access_token": data.kakaoInfo.accessToken,
        "expires_in": data.kakaoInfo.expiresIn,
        "refresh_token": data.kakaoInfo.refreshToken,
        "refresh_token_expires_in": data.kakaoInfo.refreshTokenExpiresIn,
        "scope": data.kakaoInfo.scope,
        "token_type": data.kakaoInfo.tokenType
      ]
      
      params = [
        "deviceInfo": deviceInfo,
        "kakaoInfo": kakaoInfo
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
    switch self {
    case .kakaoSignIn:
      return .requestParameters(parameters: bodyParameters ?? [:], encoding: parameterEncoding)
    }
  }
  
  public var validationType: ValidationType {
    return .none
  }
}
