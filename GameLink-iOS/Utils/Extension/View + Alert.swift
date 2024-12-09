//
//  View + Alert.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/8/24.
//

import SwiftUI

extension View {
  func failureAlert(
    isAlert: Binding<Bool>,
    description: String,
    action: @escaping () -> Void
  ) -> some View {
    modifier(
      AlertModifier(isAlert: isAlert, description: description, action: action)
    )
  }
}
