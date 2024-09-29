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
}
