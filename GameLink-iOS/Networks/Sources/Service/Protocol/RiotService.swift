//
//  RiotService.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/27/24.
//

import Foundation

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
