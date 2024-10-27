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
  
  @Published private(set) var chatList: [ChatRoomListDTO] = []
  
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
        self.chatList = data
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
