//
//  AuthInterceptor.swift
//  Networks
//
//  Created by 정도현 on 9/21/24.
//

import Alamofire
import Foundation

public class AuthInterceptor: RequestInterceptor {
  public func adapt(
    _ urlRequest: URLRequest,
    for session: Session,
    completion: @escaping (Result<URLRequest, any Error>) -> Void
  ) {
    guard let accesToken = UserDefaultsList.Auth.accessToken else {
      completion(.success(urlRequest))
      return
    }
    
    var urlRequest = urlRequest
    urlRequest.headers.add(.authorization(bearerToken: accesToken))
    completion(.success(urlRequest))
  }
  
  public func retry(
    _ request: Request,
    for session: Session,
    dueTo error: any Error,
    completion: @escaping (RetryResult) -> Void
  ) {
    
    guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
      completion(.doNotRetryWithError(error))
      return
    }
    
    guard let refreshToken = UserDefaultsList.Auth.refreshToken else {
      completion(.doNotRetry)
      return
    }
    
    DefaultAuthService().reissue(refreshToken: refreshToken) { result in
      switch result {
      case let .success(data):
        UserDefaultsList.setAuthToken(accessToken: data.accessToken, refreshToken: data.refreshToken)
        completion(.retry)
      case .failure(let error):
        completion(.doNotRetryWithError(error))
      }
    }
  }
}
