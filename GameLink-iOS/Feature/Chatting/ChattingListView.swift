//
//  ChattingListView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import SwiftUI

struct ChattingListView: View {
  
  @StateObject private var viewModel: ChatViewModel = ChatViewModel(chatService: DefaultChatService())
  
  var body: some View {
    VStack {
      Text("HI!")
    }
    .task {
      viewModel.action(.mainViewAppear)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.background1, ignoresSafeAreaEdges: .all)
  }
}

#Preview {
  ChattingListView()
}
