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
}

extension UserDefaultsList {
  
  public static func setAccessToken(value: String) {
    UserDefaultsList.Auth.accessToken = value
  }
  
  public static func clearData() {
    clearAuthData()
  }
  
  public static func clearAuthData() {
    UserDefaultsList.Auth.accessToken = nil
    UserDefaultsList.Auth.refreshToken = nil
  }
}
