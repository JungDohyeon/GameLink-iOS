//
//  DefaultUserService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/27/24.
//

import Foundation

public typealias DefaultUserService = BaseService<UserAPI>

extension DefaultUserService: UserService {
  public func kakaoLogin(accessToken: String, deviceId: String, completion: @escaping (NetworkResult<OAuthDTO>) -> Void) {
    return requestObjectWithNetworkError(.kakaoSignIn(accessToken: accessToken, deviceId: deviceId), completion: completion)
  }
  
  public func reissue(refreshToken: String, completion: @escaping (NetworkResult<ReissueDTO>) -> Void) {
    return requestObjectWithNetworkError(.reissue(refreshToken: refreshToken), completion: completion)
  }
}
