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
    case tappedEnterButton
    
    // Inner Business Action
    case _viewAppear(_ roomData: ChatroomEntity)
    case _fetchUserInfo
    
    // pageAction
    case _moveChatting
    case _moveBack
  }
  
  private let service: ChatService
  
  @Published private(set) var chatroomUserListDetail: [ChatRoomUserListDetailDTO] = []
  
  private(set) var roomData: ChatroomEntity? = nil
  
  public init(
    chatService: ChatService,
    coordinator: ChatCoordinator
  ) {
    self.service = chatService
    super.init(coordinator: coordinator)
  }
  
  public func action(_ action: Action) {
    switch action {
    case let ._viewAppear(roomData):
      self.roomData = roomData
      self.action(._fetchUserInfo)
      
    case ._fetchUserInfo:
      if let roomData = self.roomData {
        Task {
          await self.fetchUserInfo(roomId: roomData.roomId)
        }
      }
      
    case .tappedEnterButton:
      if let roomData = self.roomData {
        Task {
          await self.requestEnterChattingRoom(roomId: roomData.roomId)
        }
      }
      
    case ._moveChatting:
      if let roomData = self.roomData {
        coordinator.push(page: .inChatting(roomData))
      }
      
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
