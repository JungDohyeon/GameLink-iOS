//
//  UserDefaultsList.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import Foundation

public struct UserDefaultsList {
  public struct Auth {
    @UserDefaultsWrapper<String>(key: "accessToken")
    public static var accessToken
    
    @UserDefaultsWrapper<String>(key: "refreshToken")
    public static var refreshToken
  }
  
  public struct RiotAccount {
    @UserDefaultsWrapper<String>(key: "userId")
    public static var userId
    
    @UserDefaultsWrapper<String>(key: "summonerName")
    public static var summonerName
  }
}

extension UserDefaultsList {
  
  public static func setAuthToken(accessToken: String, refreshToken: String) {
    UserDefaultsList.Auth.accessToken = accessToken
    UserDefaultsList.Auth.refreshToken = refreshToken
  }
  
  public static func clearData() {
    clearAuthData()
  }
  
  public static func clearAuthData() {
    UserDefaultsList.Auth.accessToken = nil
    UserDefaultsList.Auth.refreshToken = nil
  }
  
  public static func setRiotAccount(userId: String, summonerName: String) {
    UserDefaultsList.RiotAccount.userId = userId
    UserDefaultsList.RiotAccount.summonerName = summonerName
  }
}
