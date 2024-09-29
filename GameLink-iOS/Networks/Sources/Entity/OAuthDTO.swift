//
//  OAuthDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Foundation

public struct OAuthDTO: Codable, Hashable {
  public let accessToken: String
  public let refreshToken: String
  public let uniqueId: String
}
