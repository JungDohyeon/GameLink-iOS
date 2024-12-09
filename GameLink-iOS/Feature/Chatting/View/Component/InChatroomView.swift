//
//  InChatroomView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/9/24.
//


import SwiftUI

public struct InChatroomView: View {
  
  public let roomData: MyChatroomContent
  
  public init(roomData: MyChatroomContent) {
    self.roomData = roomData
  }
  
  var formatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    formatter.timeZone = TimeZone(identifier: "UTC") // 시간대 설정
    return formatter
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      HStack(spacing: -20) {
        ForEach(roomData.users, id: \.self) { user in
          CachedImageView(url: URL(string: user.summonerIconUrl))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .background(
              RoundedRectangle(cornerRadius: 10)
                .stroke(.black, lineWidth: 2)
            )
            .scaledToFit()
            .frame(width: 40)
        }
      }
      .padding(.trailing, 14)
      
      VStack(alignment: .leading, spacing: 4) {
        Text(roomData.roomName)
          .glFont(.body1Bold)
          .foregroundStyle(.white)
        
        Text(roomData.lastMessageContent ?? "")
          .glFont(.body2Bold)
          .foregroundStyle(.glGray1)
      }
      
      Spacer()
      
      VStack(alignment: .trailing, spacing: 4)  {
        if let date = formatter.date(from: roomData.lastMessageTime) {
          Text(date.description.dropLast(5))
            .glFont(.body2)
            .foregroundStyle(.glGray1)
        } else {
          Text("파싱 실패")
        }
        
        Text(roomData.newMessageCount.description)
          .glFont(.body2)
          .foregroundStyle(.white)
          .padding(4)
          .background(
            Circle()
              .fill(.errorRed)
          )
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


#Preview {
  InChatroomView(roomData: MyChatroomContent(roomId: "test", roomName: "test", lastMessageTime: "test", lastMessageContent: "test", users: [], newMessageCount: 1))
}
