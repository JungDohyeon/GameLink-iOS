//
//  AlertModifier.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/8/24.
//

import SwiftUI

public struct AlertModifier: ViewModifier {
  
  @Binding var isAlert: Bool
  public let description: String
  public let action: () -> Void
  
  public init(isAlert: Binding<Bool>, description: String, action: @escaping () -> Void) {
    self._isAlert = isAlert
    self.description = description
    self.action = action
  }
  
  public func body(content: Content) -> some View {
    content
      .alert(isPresented: $isAlert) {
        Alert(
          title: Text("시스템 에러"),
          message: Text(description),
          dismissButton: .cancel(
            Text("확인"),
            action: { action() }
          )
        )
      }
  }
}
