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
  
  public enum Action {
    // User Action
    case mainViewAppear
    
    // Inner Business Action
    case _fetchChatList
  }
  
  private let service: ChatService
  
  private(set) var page: Int = 0
  private(set) var size: Int = 20
  
  @Published private(set) var chatroomList: [ChatroomEntity] = []
  
  public init(
    chatService: ChatService
  ) {
    self.service = chatService
  }
  
  public func action(_ action: Action) {
    switch action {
    case .mainViewAppear:
      self.action(._fetchChatList)
      
    case ._fetchChatList:
      self.fetchChatList()
    }
  }
}

// MARK: KAKAO LOGIN
private extension ChatViewModel {
 
  func fetchChatList() {
    service.chatroomList { result in
      switch result {
      case let .success(data):
        self.chatroomList = data.content.map {
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
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
