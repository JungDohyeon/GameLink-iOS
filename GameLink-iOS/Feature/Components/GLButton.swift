//
//  GLButton.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/30/24.
//

import SwiftUI

public struct GLButton: View {
  public let title: String
  public let isValid: Bool
  public let action: () -> Void
  public let activeColor: Color
  
  public init(
    title: String,
    isValid: Bool,
    action: @escaping () -> Void,
    activeColor: Color = .glPrimary2
  ) {
    self.title = title
    self.isValid = isValid
    self.action = action
    self.activeColor = activeColor
  }
  
  public var body: some View {
    Button(action: {
      action()
    }, label: {
      Text(title)
        .glFont(.body2Bold)
        .foregroundStyle(.white)
        .padding(.vertical, 14)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 8.0)
            .fill(isValid ? activeColor : .gray2)
        )
    })
    .disabled(!isValid)
  }
}
#Preview {
  GLButton(
    title: "test",
    isValid: true,
    action: {}
  )
}
