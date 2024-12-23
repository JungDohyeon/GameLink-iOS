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
      ScrollViewReader { proxy in
        ScrollView {
          if let userId = viewModel.userId {
            LazyVStack(spacing: 10) {
              ForEach(viewModel.chatMessages.compactMap { $0.content != nil ? $0 : nil }, id: \.chatMessageId) { message in
                SpeechBubble(
                  type: message.userId == userId ? .mine : .others,
                  data: message
                )
                .id(message.chatMessageId)
              }
            }
            .padding(.vertical, 14)
            .padding(.horizontal, GridRules.globalHorizontalPadding)
            .onChange(of: viewModel.chatMessages) { _ in
              if let lastMessage = viewModel.chatMessages.last {
                proxy.scrollTo(lastMessage.chatMessageId, anchor: .bottom)
              }
            }
          }
        }
      }
      .padding(.bottom, 56)
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
        Text(viewModel.roomData?.roomName ?? "이름을 불러오지 못했습니다")
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
    .overlay(alignment: .bottom) {
      userInputArea()
    }
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
      .disabled(self.userInput.isEmpty)
    }
    .padding(.top, 10)
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
