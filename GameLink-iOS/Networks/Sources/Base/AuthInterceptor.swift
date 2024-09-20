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
    completion(.success(urlRequest))
  }
  
  public func retry(
    _ request: Request,
    for session: Session, 
    dueTo error: any Error,
    completion: @escaping (RetryResult) -> Void
  ) {
    completion(.doNotRetry)
  }
}
