//
//  GLButton.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/30/24.
//

import SwiftUI

public struct GLButton: View {
  public var title: String
  public var isValid: Bool
  public var action: () -> Void
  
  public init(title: String, isValid: Bool, action: @escaping () -> Void) {
    self.title = title
    self.isValid = isValid
    self.action = action
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
            .fill(isValid ? .primary1 : .gray2)
        )
    })
    .disabled(!isValid)
  }
}
#Preview {
  GLButton(
    title: "test",
    isValid: false,
    action: {}
  )
}
