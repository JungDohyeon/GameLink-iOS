//
//  OauthService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Foundation
import Alamofire
import Moya

public typealias DefaultAuthService = BaseService<UserAPI>

public protocol AuthService {
  func kakaoLogin(
    data: OAuthRequestDTO,
    completion: @escaping (NetworkResult<OAuthDTO>) -> Void
  )
}

extension DefaultAuthService: AuthService {
  public func kakaoLogin(data: OAuthRequestDTO, completion: @escaping (NetworkResult<OAuthDTO>) -> Void) {
    return requestObjectWithNetworkError(.kakaoSignIn(data: data), completion: completion)
  }
}
