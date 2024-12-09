//
//  SpeechBubble.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/26/24.
//

import SwiftUI

public struct SpeechBubble: View {
  
  let type: SpeechBubbleType
  let data: ChatContentDTO
  
  public init(type: SpeechBubbleType, data: ChatContentDTO) {
    self.type = type
    self.data = data
  }
  
  public var body: some View {
    HStack {
      if type == .mine {
        Spacer()
      }
      
      HStack(spacing: 10) {
        if !data.continuous && type == .others {
          CachedImageView(url: URL(string: data.summonerIconUrl))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(
              RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
            )
            .scaledToFit()
            .frame(width: 30)
        }
        
        VStack(alignment: .leading, spacing: 6) {
          if !data.continuous && type == .others {
            Text(data.nickname)
              .glFont(.body2)
              .foregroundStyle(.glGray1)
          }
          
          if let content = data.content {
            Text(content)
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
          }
        }
        .padding(.leading, data.continuous || type == .mine ? 40 : 0)
      }
      
      if type == .others {
        Spacer()
      }
    }
  }
}

#Preview {
  VStack(spacing: 20) {
    SpeechBubble(
      type: .mine,
      data: ChatContentDTO.mock()
    )
    
    SpeechBubble(
      type: .others,
      data: ChatContentDTO.mock()
    )
  }
  .frame(maxWidth: .infinity, maxHeight: .infinity)
  .background(.black)
}
