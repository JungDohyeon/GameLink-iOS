//
//  OauthService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Foundation

public protocol AuthService {
  func kakaoLogin(
    data: OAuthRequestDTO,
    completion: @escaping (NetworkResult<OAuthDTO>) -> Void
  )
}
