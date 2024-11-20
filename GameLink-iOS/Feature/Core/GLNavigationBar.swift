//
//  GLNavigationBar.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/19/24.
//

import SwiftUI

// MARK: 커스텀 네비게이션 바
public struct GLNavigationBar<C, L, R>: ViewModifier where C: View, L: View, R: View {
  let centerContent: (() -> C)?
  let leftContent: (() -> L)?
  let rightContent: (() -> R)?
  
  public init(centerContent: (() -> C)? = nil, leftContent: (() -> L)? = nil, rightContent: (() -> R)? = nil) {
    self.centerContent = centerContent
    self.leftContent = leftContent
    self.rightContent = rightContent
  }
  
  public func body(content: Content) -> some View {
    VStack(spacing: 0) {
      ZStack {
        HStack {
          self.leftContent?()
          
          Spacer()
          
          self.rightContent?()
        }
        
        self.centerContent?()
      }
      .frame(height: 52.0)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, GridRules.globalHorizontalPadding)
      .overlay(
        Divider()
          .frame(height: 0.8)
          .overlay(.glGray3),
        alignment: .bottom
      )
      
      content
      
      Spacer()
    }
    .background(.glBackground1)
    .navigationBarBackButtonHidden()
  }
}
