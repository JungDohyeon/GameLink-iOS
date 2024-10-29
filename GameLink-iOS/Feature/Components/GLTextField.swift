//
//  GLTextFieldView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/29/24.
//

import SwiftUI

public struct GLTextField: View {
  
  public let type: GLTextFieldType
  public let focusState: FocusState<GLTextFieldType?>.Binding
  
  @Binding var inputText: String
  
  public init(
    type: GLTextFieldType,
    focusState: FocusState<GLTextFieldType?>.Binding,
    inputText: Binding<String>
  ) {
    self.type = type
    self.focusState = focusState
    self._inputText = inputText
  }
  
  public var body: some View {
    TextField(
      "",
      text: $inputText
    )
    .placeholder(when: inputText.isEmpty, placeholder: {
      Text(" " + type.placeholder)
        .glFont(.body2)
        .foregroundStyle(.gray1)
    })
    .tint(.primary2)
    .padding(.vertical, 12)
    .padding(.horizontal, 16)
    .background(
      RoundedRectangle(cornerRadius: 8)
        .fill(.background1)
        .stroke(focusState.wrappedValue == type ? .primary2 : .white, lineWidth: 1.3)
    )
    .autocorrectionDisabled()
    .textInputAutocapitalization(.never)
    .keyboardType(.default)
    .focused(focusState, equals: type)
  }
}

#Preview {
  struct PreviewWrapper: View {
    @State private var inputText = ""
    @FocusState private var focusState: GLTextFieldType?
    
    var body: some View {
      VStack(spacing: 16) {
        GLTextField(
          type: .nickname,
          focusState: $focusState,
          inputText: $inputText
        )
        
        GLTextField(
          type: .gametag,
          focusState: $focusState,
          inputText: $inputText
        )
      }
    }
  }
  
  return PreviewWrapper()
}
