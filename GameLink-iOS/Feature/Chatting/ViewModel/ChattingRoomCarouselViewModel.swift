//
//  ChattingRoomCarouselViewModel.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/6/24.
//

import Combine
import Foundation

final class ChattingRoomCarouselViewModel: BaseViewModel<ChatCoordinator>, ObservableObject {
  
  public enum Action {
    // User Action
    case tappedEnterButton(_ roomId: String)
    
    // Inner Business Action
    case _viewAppear(_ roomId: String)
    case _fetchUserInfo(_ roomId: String)
    
    // pageAction
    case _moveChatting
    case _moveBack
  }
  
  private let service: ChatService
  
  @Published private(set) var chatroomUserListDetail: [ChatRoomUserListDetailDTO] = []
  
  public init(
    chatService: ChatService,
    coordinator: ChatCoordinator
  ) {
    self.service = chatService
    super.init(coordinator: coordinator)
  }
  
  public func action(_ action: Action) {
    switch action {
    case let ._viewAppear(roomId):
      self.action(._fetchUserInfo(roomId))
      
    case let ._fetchUserInfo(roomId):
      Task {
        await self.fetchUserInfo(roomId: roomId)
      }
      
    case let .tappedEnterButton(roomId):
      Task {
        await self.requestEnterChattingRoom(roomId: roomId)
      }
      
    case ._moveChatting:
      coordinator.push(page: .inChatting)
      
    case ._moveBack:
      self.coordinator.pop()
    }
  }
}

private extension ChattingRoomCarouselViewModel {
  
  @MainActor
  func fetchUserInfo(roomId: String) async {
    service.chatroomUserDetailInfo(roomId: roomId) { result in
      switch result {
      case let .success(data):
        self.chatroomUserListDetail = data
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
  
  @MainActor
  func requestEnterChattingRoom(roomId: String) async {
    service.checkUserEntered(roomId: roomId) { result in
      switch result {
      case let .success(data):
        if data.result {
          self.action(._moveChatting)
        } else {
          print("입장 실패")
        }
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
