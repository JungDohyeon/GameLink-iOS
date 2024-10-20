//
//  ChattingListView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import SwiftUI

struct ChattingListView: View {
  
  @ObservedObject private var viewModel: ChatViewModel = ChatViewModel()
  
  var body: some View {
    VStack {
      Text("HI!")
    }
    .task {
      viewModel.action(.mainViewAppear)
    }
  }
}

#Preview {
  ChattingListView()
}
