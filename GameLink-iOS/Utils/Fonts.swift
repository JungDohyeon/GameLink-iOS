//
//  Fonts.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/16/24.
//

import SwiftUI

public enum GLFontType {
  case head1
  case head2
  case title1
  case title2
  case body1
  case body1Bold
  case body2
  case body2Bold
  case navi
}

public extension View {
  func glFont(_ fontStyle: GLFontType) -> some View {
    switch fontStyle {
      
    case .head1:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 36))
        .lineSpacing(16))
      
    case .head2:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 28))
        .lineSpacing(7))
      
    case .title1:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 20))
        .lineSpacing(4))
      
    case .title2:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 18))
        .lineSpacing(3))
      
    case .body1:
      return AnyView(self
        .font(.custom("Pretendard-Regular", size: 16))
        .lineSpacing(3))
      
    case .body1Bold:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 16))
        .lineSpacing(3))
      
    case .body2:
      return AnyView(self
        .font(.custom("Pretendard-Regular", size: 14))
        .lineSpacing(3))
      
    case .body2Bold:
      return AnyView(self
        .font(.custom("Pretendard-Bold", size: 14))
        .lineSpacing(3))
      
    case .navi:
      return AnyView(self
        .font(.custom("Pretendard-Regular", size: 12))
        .lineSpacing(4))
    }
  }
}
