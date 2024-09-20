//
//  ErrorResponse.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import Foundation

public struct ErrorResponse: Codable {
  public let code: Int
  public let message: String
}
