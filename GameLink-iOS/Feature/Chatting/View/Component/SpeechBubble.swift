//
//  SpeechBubble.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/26/24.
//

import SwiftUI

public struct SpeechBubble: View {
  
  let type: SpeechBubbleType
  let text: String
  
  public init(type: SpeechBubbleType, text: String) {
    self.type = type
    self.text = text
  }
  
  public var body: some View {
    HStack {
      if type == .mine {
        Spacer()
      }
      
      Text(text)
        .glFont(.body1)
        .foregroundStyle(type.textColor)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(
          CustomRoundedRectangle(
            topLeft: type == .mine ? 16 : 2,
            topRight: type == .mine ? 2 : 16,
            bottomLeft: 16,
            bottomRight: 16
          )
          .fill(type.bubbleColor)
        )
      
      if type == .others {
        Spacer()
      }
    }
  }
}

#Preview {
  VStack(spacing: 20) {
    SpeechBubble(type: .others, text: "test")
    
    SpeechBubble(type: .mine, text: "test")
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
