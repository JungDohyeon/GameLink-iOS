//
//  InChattingView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 11/26/24.
//

import SwiftUI

struct InChattingView: View {
  
  @ObservedObject private var viewModel: InChattingViewModel
  
  let roomData: ChatroomEntity
  
  @State private var userInput: String = ""
  
  init(viewModel: InChattingViewModel, roomData: ChatroomEntity) {
    self.viewModel = viewModel
    self.roomData = roomData
  }
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        if let userId = viewModel.userId {
          LazyVStack(spacing: 10) {
            ForEach(viewModel.chatMessages.compactMap { $0.content != nil ? $0 : nil }, id: \.chatMessageId) { message in
              SpeechBubble(type: message.userId == userId ? .mine : .others, text: message.content!)
                .onAppear {
                  if viewModel.hasNext && message.chatMessageId == viewModel.chatMessages.last?.chatMessageId {
                    viewModel.action(._fetchMessage)
                  }
                }
            }
          }
          .padding(.vertical, 14)
          .padding(.horizontal, GridRules.globalHorizontalPadding)
        }
      }
      
      userInputArea()
    }
    .task {
      viewModel.action(._viewAppear(roomData))
    }
    .onDisappear {
      print("채팅 방 나가기")
      viewModel.action(._stompDisconnect)
    }
    .glNavigation(
      centerContent: {
        Text("채팅방 이름")
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
      }
    )
  }
}

private extension InChattingView {
  
  @ViewBuilder
  func userInputArea() -> some View {
    HStack(spacing: 12) {
      TextField("", text: $userInput)
        .glFont(.body1)
        .foregroundStyle(.glGray1)
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .autocorrectionDisabled()
        .textInputAutocapitalization(.never)
        .background(
          Capsule()
            .fill(.glGray3)
        )
        .tint(.glPrimary1)
      
      Button {
        viewModel.action(._sendMessage(self.userInput))
        userInput.removeAll()
      } label: {
        Image(systemName: "arrow.up")
          .foregroundStyle(.glBackground2)
          .padding(.vertical, 8)
          .padding(.horizontal, 12)
          .background(
            Circle()
              .fill(.primary1)
          )
      }
    }
    .padding(.horizontal, 16)
    .background(
      .glBackground2
    )
  }
}

#Preview {
  InChattingView(
    viewModel: InChattingViewModel(
      stompService: DefaultStompService(service: DefaultChatService()),
      coordinator: ChatCoordinator(
        initialScene: .inChatting(
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
