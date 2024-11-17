//
//  AuthService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Foundation

public protocol UserService {
  func kakaoLogin(
    accessToken: String,
    deviceId: String,
    completion: @escaping (NetworkResult<OAuthDTO>) -> Void
  )
  
  func reissue(
    refreshToken: String,
    completion: @escaping (NetworkResult<ReissueDTO>) -> Void
  )
}
