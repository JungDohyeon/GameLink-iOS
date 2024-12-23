//
//  ChattingRoomCarouselView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import SwiftUI

struct ChattingRoomCarouselView: View {
  
  @GestureState var offset: CGFloat = 0
  @State private(set) var currentIdx: Int = 0
  
  @ObservedObject private var viewModel: ChattingRoomCarouselViewModel
  
  let roomData: ChatroomEntity
  
  init(viewModel: ChattingRoomCarouselViewModel, roomData: ChatroomEntity) {
    self.viewModel = viewModel
    self.roomData = roomData
  }
  
  var body: some View {
    GeometryReader { geo in
      let width = geo.size.width - 24
      let spacing: CGFloat = 6
      let adjustedWidth = width + spacing
      
      LazyHStack(spacing: spacing) {
        ForEach(
          Array(zip(viewModel.chatroomUserListDetail.indices, viewModel.chatroomUserListDetail)),
          id: \.0
        ) { index, userData in
          let isSelected = index == currentIdx
          
          UserCarouselCardView(userData: userData)
            .frame(width: width)
            .scaleEffect(isSelected ? 1.0 : 0.94)
        }
      }
      .padding(.horizontal, (geo.size.width - width) / 2)
      .offset(x: CGFloat(currentIdx) * -adjustedWidth + offset)
      .gesture(
        DragGesture()
          .updating($offset, body: { value, out, _ in
            out = value.translation.width
          })
          .onEnded(
            { value in
              let offsetX = value.translation.width
              let progress = -offsetX / adjustedWidth
              let roundIndex = progress.rounded()
              
              currentIdx = max(min(currentIdx + Int(roundIndex), viewModel.chatroomUserListDetail.count - 1), 0)
            }
          )
      )
    }
    .padding(.vertical, 30)
    .padding(.horizontal, GridRules.globalHorizontalPadding)
    .glNavigation(
      centerContent: {
        Text(self.roomData.roomName)
          .glFont(.body1Bold)
          .foregroundStyle(.white)
      },
      leftContent: {
        Image(systemName: "chevron.left").bold()
          .foregroundStyle(.white)
          .padding(.horizontal, 6)
          .padding(.vertical, 4)
          .onTapGesture {
            viewModel.action(._moveBack)
          }
      },
      rightContent: {
        Button {
          viewModel.action(.tappedEnterButton)
        } label: {
          Text("참여")
            .glFont(.body1Bold)
            .foregroundStyle(.glPrimary2)
        }
      }
    )
    .task {
      viewModel.action(._viewAppear(self.roomData))
    }
  }
}

#Preview {
  ChattingRoomCarouselView(
    viewModel: ChattingRoomCarouselViewModel(
      chatService: DefaultChatService(),
      coordinator: ChatCoordinator(
        initialScene: .userCarousel(
          ChatroomEntity(
            roomId: "test",
            roomName: "test",
            userCount: 1,
            maxUserCount: 3,
            leaderTierText: "S1",
            leaderTier: .silver,
            positions: [.adcarry]
          )
        )
      )
    ),
    roomData: ChatroomEntity(
      roomId: "test",
      roomName: "test",
      userCount: 1,
      maxUserCount: 3,
      leaderTierText: "S1",
      leaderTier: .silver,
      positions: [.adcarry]
    )
  )
}
