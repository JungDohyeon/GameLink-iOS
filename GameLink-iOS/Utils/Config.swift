//
//  Config.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import Foundation

public enum Config {
  public enum Keys {
    public enum Plist {
      static let baseURL = "BASE_URL"
      static let kakaoKey = "KAKAO_APP_KEY"
      static let socketURL = "SOCKET_URL"
    }
  }
  
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("plist cannot found.")
    }
    return dict
  }()
}

extension Config {
  public static let baseURL: String = {
    guard let key = Config.infoDictionary[Keys.Plist.baseURL] as? String else {
      fatalError("Base URL is not set in plist for this configuration.")
    }
    
    return key
  }()
  
  public static let kakaoKey: String = {
    guard let key = Config.infoDictionary[Keys.Plist.kakaoKey] as? String else {
      fatalError("KakaoKey is not set in plist for this configuration.")
    }
    
    return key
  }()
  
  public static let socketURL: String = {
    guard let key = Config.infoDictionary[Keys.Plist.socketURL] as? String else {
      fatalError("socketURL is not set in plist for this configuration.")
    }
    
    return key
  }()
}
