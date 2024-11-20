//
//  ChattingRoomCarouselView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/20/24.
//

import SwiftUI

struct ChattingRoomCarouselView: View {
  
  @EnvironmentObject private var viewModel: ChatViewModel
  
  @GestureState var offset: CGFloat = 0
  @State private(set) var currentIdx: Int = 0
  
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
            .animation(.spring(), value: isSelected)
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
        Text(viewModel.selectedChatroom?.roomName ?? "채팅방 정보 오류")
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
          // TODO: Chatting 방 참가
        } label: {
          Text("참여")
            .glFont(.body1Bold)
            .foregroundStyle(.glPrimary2)
        }
      }
    )
  }
}

#Preview {
  ChattingRoomCarouselView()
    .environmentObject(ChatViewModel(chatService: DefaultChatService()))
}
