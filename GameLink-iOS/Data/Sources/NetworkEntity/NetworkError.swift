//
//  NetworkError.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import Foundation

public enum NetworkError: Error {
  case invalidResponse
  case invalidData
  case requestFailed(error: Error)
  case decodingFailed
  case requestErr
  case serverError
  case unknown
}
