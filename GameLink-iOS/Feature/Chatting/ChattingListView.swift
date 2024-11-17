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
    VStack {
      Text("HI!")
    }
    .onAppear {
      viewModel.action(.mainViewAppear)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.background1, ignoresSafeAreaEdges: .all)
  }
}

#Preview {
  ChattingListView()
    .environmentObject(ChatViewModel(chatService: DefaultChatService()))
}
