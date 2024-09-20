//
//  NetworkResult.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import Foundation

public enum NetworkResult<T> {
  case success(T)
  case failure(NetworkError)
}
