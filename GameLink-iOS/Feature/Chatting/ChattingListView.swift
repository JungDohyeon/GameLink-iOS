//
//  ChattingListView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import SwiftUI

struct ChattingListView: View {
  
  @EnvironmentObject private var viewModel: ChatViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      header()
        .padding(.top, 14)
      
      roomList()
    }
    .onAppear {
      viewModel.action(.mainViewAppear)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.background1, ignoresSafeAreaEdges: .all)
  }
}

private extension ChattingListView {
  
  @ViewBuilder
  func header() -> some View {
    Text("Game-Link")
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: 60)
      .glFont(.head2)
      .foregroundStyle(.primary2)
      .padding(.horizontal, GridRules.globalHorizontalPadding)
  }
  
  
  @ViewBuilder
  func roomList() -> some View {
    ScrollView {
      LazyVStack(spacing: 0) {
        ForEach(viewModel.chatroomList, id: \.self) { chatroom in
          VStack(spacing: 0) {
            ChatroomView(roomData: chatroom)
            
            Divider()
              .frame(height: 0.8)
              .overlay(Color.glGray2)
          }
        }
      }
    }
  }
}

#Preview {
  ChattingListView()
    .environmentObject(ChatViewModel(chatService: DefaultChatService()))
}
