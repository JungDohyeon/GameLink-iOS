//
//  RiotService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/27/24.
//

import Foundation
import Alamofire
import Moya

public typealias DefaultRiotService = BaseService<RiotAPI>

public protocol RiotService {
  func checkAccount(
    completion: @escaping (NetworkResult<RiotAccountDTO>) -> Void
  )
  
  func changeAccount(
    gameName: String,
    tagLine: String,
    completion: @escaping (NetworkResult<VoidResponse>) -> Void
  )
  
  func checkRecord(
    start: Int,
    completion: @escaping (NetworkResult<[RiotRecordDTO]>) -> Void
  )
  
  func refreshRecord(
    completion: @escaping (NetworkResult<VoidResponse>) -> Void
  )
  
  func refreshAccount(
    userId: Int,
    completion: @escaping (NetworkResult<VoidResponse>) -> Void
  )
  
  func registerAccount(
    gameName: String,
    tagLine: String,
    completion: @escaping (NetworkResult<VoidResponse>) -> Void
  )
}

extension DefaultRiotService: RiotService {
  public func checkAccount(completion: @escaping (NetworkResult<RiotAccountDTO>) -> Void) {
      return requestObjectWithNetworkError(.checkAccount, completion: completion)
  }
  
  public func changeAccount(gameName: String, tagLine: String, completion: @escaping (NetworkResult<VoidResponse>) -> Void) {
    return requestObjectWithNetworkError(.changeAccount(gameName: gameName, tagLine: tagLine), completion: completion)
  }
  
  public func checkRecord(start: Int, completion: @escaping (NetworkResult<[RiotRecordDTO]>) -> Void) {
    return requestObjectWithNetworkError(.checkRecord(start: start), completion: completion)
  }
  
  public func refreshRecord(completion: @escaping (NetworkResult<VoidResponse>) -> Void) {
    return requestObjectWithNetworkError(.refreshRecord, completion: completion)
  }
  
  public func refreshAccount(userId: Int, completion: @escaping (NetworkResult<VoidResponse>) -> Void) {
    return requestObjectWithNetworkError(.refreshAccount(userId: userId), completion: completion)
  }
  
  public func registerAccount(gameName: String, tagLine: String, completion: @escaping (NetworkResult<VoidResponse>) -> Void) {
    return requestObjectWithNetworkError(.registerAccount(gameName: gameName, tagLine: tagLine), completion: completion)
  }
}
