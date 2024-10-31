//
//  ReissueDTO.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/1/24.
//

import Foundation

public struct ReissueDTO: Codable, Hashable {
  public let accessToken: String
  public let refreshToken: String
}
