//
//  ChatroomView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/18/24.
//

import SwiftUI

public struct ChatroomView: View {
  
  public let roomData: ChatroomEntity
  
  public init(roomData: ChatroomEntity) {
    self.roomData = roomData
  }
  
  public var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 2) {
        Text(roomData.roomName)
          .glFont(.body1Bold)
          .foregroundStyle(.white)
        
        HStack(spacing: 4) {
          Image(uiImage: roomData.leaderTier.tierImage)
            .resizable()
            .frame(width: 30, height: 30)
          
          Text(roomData.leaderTierText)
            .glFont(.body2Bold)
            .foregroundStyle(.glGray1)
        }
      }
      
      Spacer()
      
      HStack(spacing: 8) {
        ForEach(roomData.positions, id: \.self) { position in
          if let positionImage = position.positionImage {
            Image(uiImage: positionImage)
              .resizable()
              .frame(width: 40, height: 40)
          }
        }
      }
    }
    .padding(.vertical, 15)
    .padding(.horizontal, GridRules.globalHorizontalPadding)
    .background(.background1, ignoresSafeAreaEdges: .all)
  }
}

#Preview {
  ChatroomView(
    roomData: ChatroomEntity(
      roomId: "test",
      roomName: "test",
      userCount: 1,
      maxUserCount: 2,
      leaderTierText: "G4",
      leaderTier: .gold,
      positions: [.mid])
  )
}
