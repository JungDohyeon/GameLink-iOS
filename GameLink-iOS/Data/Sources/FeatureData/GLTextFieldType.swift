//
//  GLTextFieldType.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/29/24.
//

import Foundation

public enum GLTextFieldType {
  case nickname
  case gametag
  case password
  
  public var placeholder: String {
    switch self {
    case .nickname:
      return "닉네임을 입력해주세요"
    case .gametag:
      return "게임 태그를 입력해주세요"
    case .password:
      return "비밀번호를 입력해주세요"
    }
  }
}
