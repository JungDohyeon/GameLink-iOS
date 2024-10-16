//
//  Utils.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import UIKit

final class Utils {
  
  // 디바이스 고유 넘버 반환
  static func getDeviceUUID() -> String {
    return UIDevice.current.identifierForVendor!.uuidString
  }
  
  // 디바이스 이름 반환
  static func getDeviceModelName() -> String {
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    switch (screenWidth, screenHeight) {
    case (320, 480):
      return "iPhone 3GS"
    case (320, 480):
      return "iPhone 4 or iPhone 4s"
    case (320, 568):
      return "iPhone 5, iPhone 5c, iPhone 5s, or iPhone SE (1st Gen)"
    case (375, 667):
      return "iPhone 6, iPhone 6s, iPhone 7, iPhone 8, iPhone SE (2nd Gen)"
    case (375, 812):
      return "iPhone 12 mini, iPhone 13 mini"
    case (414, 736):
      return "iPhone 6 Plus, iPhone 6s Plus, iPhone 7 Plus, iPhone 8 Plus"
    case (375, 812):
      return "iPhone X, iPhone XS, iPhone 11 Pro"
    case (414, 896):
      return "iPhone XR, iPhone 11"
    case (390, 844):
      return "iPhone 12, iPhone 12 Pro, iPhone 13, iPhone 13 Pro, iPhone 14"
    case (393, 852):
      return "iPhone 14 Pro"
    case (414, 896):
      return "iPhone XS Max, iPhone 11 Pro Max"
    case (428, 926):
      return "iPhone 12 Pro Max, iPhone 13 Pro Max, iPhone 14 Plus"
    case (430, 932):
      return "iPhone 14 Pro Max"
    case (1024, 768):
      return "iPad, iPad Mini"
    case (1112, 834):
      return "iPad Pro 10.5 inch, iPad Air"
    case (1194, 834):
      return "iPad Pro 11 inch"
    case (1366, 1024):
      return "iPad Pro 12.9 inch"
    default:
      return "Unknown"
    }
  }
}
