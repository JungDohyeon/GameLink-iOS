//
//  ChattingRoomCardView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/6/24.
//

import SwiftUI

struct ChattingRoomCardView: View {
  let roomName: String
  let tier: Tier
  let tierSpec: String
  let position: GamePosition
  
  init(roomName: String, tier: Tier, tierSpec: String, position: GamePosition) {
    self.roomName = roomName
    self.tier = tier
    self.tierSpec = tierSpec
    self.position = position
  }
  
  var body: some View {
    HStack {
      HStack(spacing: 12) {
        Rectangle()
          .fill(.green)
        
        VStack {
          Text(roomName)
            .foregroundStyle(.white)
            .glFont(.body1Bold)
          
          Spacer()
          HStack(spacing: 4) {
            if case .lol = tier {
              if let tierImage = tier.tierImage {
                Image(uiImage: tierImage)
                  .resizable()
                  .frame(width: 30, height: 30)
              } else {
                Text("Failure Fetch Image")
              }
            }
            
            Text(tierSpec)
              .foregroundStyle(.gray1)
              .glFont(.body2Bold)
          }
        }
      }
      
      Spacer()
      
      if case .lol = position {
        if let positionImage = position.positionImage {
          Image(uiImage: positionImage)
            .resizable()
            .frame(width: 40, height: 40)
        } else {
          Text("Failure Fetch Image")
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.background1, ignoresSafeAreaEdges: .all)
  }
}

#Preview {
  ChattingRoomCardView(
    roomName: "Test",
    tier: .lol(.bronze),
    tierSpec: "G4",
    position: .lol(.adcarry)
  )
}
