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
    NavigationStack(path: $viewModel.path) {
      VStack(spacing: 0) {
        header()
          .padding(.top, 14)
        
        filterSection()
        
        roomList()
      }
      .onAppear {
        viewModel.action(.mainViewAppear)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.background1, ignoresSafeAreaEdges: .all)
      .navigationDestination(for: ChattingViewDestination.self) { destination in
        switch destination {
        case .main:
          ChattingListView()
            .environmentObject(viewModel)
          
        case .filterList:
          ChattingFilterDetailView()
            .environmentObject(viewModel)
            .toolbar(.hidden, for: .tabBar)
        }
      }
    }
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
  func filterSection() -> some View {
    VStack(spacing: 8) {
      HStack(spacing: 5) {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack(alignment: .center, spacing: 8) {
            filterCapsule(
              type: .position,
              isSelected: false,
              action: { viewModel.action(._moveFilterList) }
            )
            
            filterCapsule(
              type: .gameType,
              isSelected: false,
              action: { viewModel.action(._moveFilterList) }
            )
            
            filterCapsule(
              type: .tier,
              isSelected: false,
              action: { viewModel.action(._moveFilterList) }
            )
          }
        }
        .frame(height: 35, alignment: .center)
        .padding(.vertical, 10)
        
        Button {
          viewModel.action(._moveFilterList)
        } label: {
          Image(.filterIcon)
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(
              Capsule()
                .fill(.glPrimary3)
            )
        }
      }
      .padding(.horizontal, GridRules.globalHorizontalPadding)
      
      Divider()
        .frame(height: 0.8)
        .overlay(.glGray2)
    }
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
          .onAppear {
            if viewModel.hasNext && chatroom == viewModel.chatroomList.last {
              viewModel.action(._fetchNextPage)
            }
          }
        }
      }
    }
  }
  
  @ViewBuilder
  func filterCapsule(
    type: GameFilter,
    isSelected: Bool,
    action: @escaping () -> Void
  ) -> some View {
    Button {
      action()
    } label: {
      HStack(spacing: 4) {
        Text("모든 " + type.rawValue)
        Image(systemName: "chevron.down")
      }
      .glFont(.body2Bold)
      .foregroundStyle(isSelected ? .glPrimary3 : .glGray1)
      .padding(.vertical, 9)
      .padding(.horizontal, 10)
      .background(
        Capsule()
          .fill(.clear)
          .strokeBorder(isSelected ? .glPrimary3 : .glGray1)
      )
    }
  }
}

#Preview {
  ChattingListView()
    .environmentObject(ChatViewModel(chatService: DefaultChatService()))
}
