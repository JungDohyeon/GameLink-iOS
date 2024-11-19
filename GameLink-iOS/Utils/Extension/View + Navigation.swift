//
//  View + Navigation.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/19/24.
//

import SwiftUI

// MARK: Custom Navigation Modifier
extension View {
  func glNavigation<C, L, R>(
    centerContent: @escaping (() -> C),
    leftContent: @escaping (() -> L),
    rightContent: @escaping (() -> R)
  ) -> some View where C: View, L: View, R: View {
    modifier(
      GLNavigationBar(centerContent: centerContent, leftContent: leftContent, rightContent: rightContent)
    )
  }
  
  func glNavigation<C, L>(
    centerContent: @escaping (() -> C),
    leftContent: @escaping (() -> L)
  ) -> some View where C: View, L: View {
    modifier(
      GLNavigationBar(centerContent: centerContent, leftContent: leftContent, rightContent: { EmptyView() })
    )
  }
  
  func glNavigation<C, R>(
    centerContent: @escaping (() -> C),
    rightContent: @escaping (() -> R)
  ) -> some View where C: View, R: View {
    modifier(
      GLNavigationBar(centerContent: centerContent, leftContent: { EmptyView() }, rightContent: rightContent)
    )
  }
}
