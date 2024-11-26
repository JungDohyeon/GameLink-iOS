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
    case tappedSelectPositionButton(LOLPosition)
    case tappedEnterChattingRoomButton
    
    // Inner Business Action
    case _fetchChatList
    case _fetchNextPage
    case _fetchUserDetailList
    case _setSelectPositionView(_ isVisible: Bool)
    
    // pageAction
    case _moveFilterList
    case _moveUserDetailCarousel
    case _moveChatting
    case _moveBack
  }
  
  private let service: ChatService
  
  private(set) var page: Int = 0
  private(set) var size: Int = 20
  
  @Published private(set) var showSelectPositionView: Bool = false
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
      self.showSelectPositionView = true
      
    case let .tappedSelectPositionButton(position):
      if let roomId = self.selectedChatroom?.roomId {
        self.selectPosition(roomId: roomId, position: position)
      }
      
    case ._fetchChatList:
      self.fetchChatList(page: self.page, size: self.size)
      
    case ._fetchNextPage:
      self.page += 1
      self.action(._fetchChatList)
      
    case ._fetchUserDetailList:
      if let roomId = self.selectedChatroom?.roomId {
        self.fetchChatroomUserDetailInfo(roomId: roomId)
      }
      
    case ._moveFilterList:
      self.path.append(.filterList)
      
    case ._moveUserDetailCarousel:
      self.path.append(.userDetailCarousel)
      
    case ._moveChatting:
      print("채팅방 이동!")
      
    case ._moveBack:
      if path.count > 0 {
        path.removeLast()
      }
      
    case let ._setSelectPositionView(bool):
      self.showSelectPositionView = bool
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
  
  func selectPosition(roomId: String, position: LOLPosition) {
    service.selectPosition(roomId: roomId, position: position) { result in
      switch result {
      case .success:
        self.action(._setSelectPositionView(false))
        self.action(._fetchUserDetailList)
        
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
  
  func requestEnterChattingRoom(roomId: String) {
    service.checkUserEntered(roomId: roomId) { result in
      switch result {
      case let .success(entered):
        if entered {
          self.action(._moveChatting)
        } else {
          print("채팅방 입장 실패")
        }
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
