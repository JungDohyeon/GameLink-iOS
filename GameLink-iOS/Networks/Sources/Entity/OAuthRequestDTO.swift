//
//  OAuthRequestDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Foundation

public struct OAuthRequestDTO: Codable, Hashable {
  public let deviceInfo: DeviceInfo
  public let kakaoInfo: KakaoInfo
}

public struct DeviceInfo: Codable, Hashable {
  public let uniqueId: String
  public let model: String
  public let deviceId: String
  public let deviceName: String
}

public struct KakaoInfo: Codable, Hashable {
  public let accessToken: String
  public let expiresIn: Int
  public let refreshToken: String
  public let refreshTokenExpiresIn: Int
  public let scope: String
  public let tokenType: String
}
