//
//  ChattingListViewModel.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/6/24.
//

import Combine
import Foundation

final class ChattingListViewModel: BaseViewModel<ChatCoordinator>, ObservableObject {
  
  public enum Action {
    // User Action
    case viewAppear
    case tappedChatroom(ChatroomEntity)
    case tappedSelectPositionButton(LOLPosition)
    
    // Inner Business Action
    case _fetchChatroomList
    case _fetchNextPage
    case _setSelectPositionView(_ isVisible: Bool)
    
    // pageAction
    case _moveFilterList
    case _moveUserDetailCarousel
    case _moveBack
  }
  
  private let service: ChatService
  
  private(set) var page: Int = 0
  private(set) var size: Int = 20
  private(set) var hasNext: Bool = false
  
  @Published private(set) var showSelectPositionView: Bool = false
  @Published private(set) var selectedChatroom: ChatroomEntity? = nil
  @Published private(set) var chatroomList: [ChatroomEntity] = []
  
  public init(
    chatService: ChatService,
    coordinator: ChatCoordinator
  ) {
    self.service = chatService
    super.init(coordinator: coordinator)
  }
  
  public func action(_ action: Action) {
    switch action {
    case .viewAppear:
      self.selectedChatroom = nil
      self.page = 0
      self.hasNext = false
      self.chatroomList = []
      self.action(._fetchChatroomList)
      
    case let .tappedChatroom(chatroom):
      self.selectedChatroom = chatroom
      self.showSelectPositionView = true
      
    case let .tappedSelectPositionButton(position):
      if let roomId = self.selectedChatroom?.roomId {
        Task {
          await self.selectPosition(roomId: roomId, position: position)
        }
      }
      
    case ._fetchChatroomList:
      Task {
        await self.fetchChatList(page: self.page, size: self.size)
      }
      
    case ._fetchNextPage:
      self.page += 1
      self.action(._fetchChatroomList)
      
    case ._moveFilterList:
      self.coordinator.push(page: .filterList)
      
    case ._moveUserDetailCarousel:
      if let roomData = self.selectedChatroom {
        print("이동!@!@!")
        self.coordinator.push(page: .userCarousel(roomData))
      }
      
    case ._moveBack:
      self.coordinator.pop()
      
    case let ._setSelectPositionView(bool):
      self.showSelectPositionView = bool
    }
  }
}

private extension ChattingListViewModel {
  
  @MainActor
  func fetchChatList(page: Int, size: Int) async {
    service.chatroomList(page: page, size: size) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case let .success(data):
        self.chatroomList.append(
          contentsOf: data.content.map {
            ChatroomEntity.init(dto: $0)
          }
        )
        
        self.hasNext = data.hasNext
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
  
  @MainActor
  func selectPosition(roomId: String, position: LOLPosition) async {
    service.selectPosition(roomId: roomId, position: position) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success:
        self.action(._setSelectPositionView(false))
        self.action(._moveUserDetailCarousel)
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
