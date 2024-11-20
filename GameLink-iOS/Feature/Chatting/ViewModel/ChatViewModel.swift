//
//  ChatViewModel.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/16/24.
//

import Combine
import Foundation

@MainActor
final class ChatViewModel: ObservableObject {
  
  @Published var path: [ChattingViewDestination] = []
  
  public enum Action {
    // User Action
    case mainViewAppear
    case tappedChatroom(ChatroomEntity)
    
    // Inner Business Action
    case _fetchChatList
    case _fetchNextPage
    
    // pageAction
    case _moveFilterList
    case _moveUserDetailCarousel
    case _moveBack
  }
  
  private let service: ChatService
  
  private(set) var page: Int = 0
  private(set) var size: Int = 20
  
  @Published private(set) var hasNext: Bool = false
  @Published private(set) var selectedChatroom: ChatroomEntity? = nil
  @Published private(set) var chatroomList: [ChatroomEntity] = []
  @Published private(set) var chatroomUserListDetail: [ChatRoomUserListDetailDTO] = []
  
  public init(
    chatService: ChatService
  ) {
    self.service = chatService
  }
  
  public func action(_ action: Action) {
    switch action {
    case .mainViewAppear:
      self.selectedChatroom = nil
      self.page = 0
      self.hasNext = false
      self.chatroomList = []
      self.action(._fetchChatList)
      
    case let .tappedChatroom(chatroom):
      self.selectedChatroom = chatroom
      self.fetchChatroomUserDetailInfo(roomId: chatroom.roomId)
      
    case ._fetchChatList:
      self.fetchChatList(page: self.page, size: self.size)
      
    case ._fetchNextPage:
      self.page += 1
      self.action(._fetchChatList)
      
    case ._moveFilterList:
      self.path.append(.filterList)
      
    case ._moveUserDetailCarousel:
      self.path.append(.userDetailCarousel)
      
    case ._moveBack:
      if path.count > 0 {
        path.removeLast()
      }
    }
  }
}

private extension ChatViewModel {
  
  func fetchChatList(page: Int, size: Int) {
    service.chatroomList(page: page, size: size) { result in
      switch result {
      case let .success(data):
        self.chatroomList.append(
          contentsOf: data.content.map {
            ChatroomEntity(
              roomId: $0.roomId,
              roomName: $0.roomName,
              userCount: $0.userCount,
              maxUserCount: $0.maxUserCount,
              leaderTierText: $0.leaderTier,
              leaderTier: LOLTier.stringToLOLTier(tier: String($0.leaderTier.first!)),
              positions: [.adcarry]
            )
          }
        )
        
        self.hasNext = data.hasNext
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
  
  func fetchChatroomUserDetailInfo(roomId: String) {
    service.chatroomUserDetailInfo(roomId: roomId) { result in
      switch result {
      case let .success(data):
        self.chatroomUserListDetail = data
        self.action(._moveUserDetailCarousel)
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
