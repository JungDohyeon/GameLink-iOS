//
//  DefaultAuthService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/27/24.
//

import Foundation

public typealias DefaultAuthService = BaseService<UserAPI>

extension DefaultAuthService: AuthService {
  public func kakaoLogin(data: OAuthRequestDTO, completion: @escaping (NetworkResult<OAuthDTO>) -> Void) {
    return requestObjectWithNetworkError(.kakaoSignIn(data: data), completion: completion)
  }
}
