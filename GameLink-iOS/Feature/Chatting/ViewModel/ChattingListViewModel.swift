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
    case tappedMyRoom(MyChatroomContent)
    case tappedSelectPositionButton(LOLPosition)
    
    // Inner Business Action
    case _fetchChatroomList(isMy: Bool)
    case _fetchNextPage
    case _setSelectPositionView(_ isVisible: Bool)
    case _setPage(page: Int)
    
    // pageAction
    case _moveFilterList
    case _moveUserDetailCarousel
    case _moveBack
  }
  
  private let service: ChatService
  private let riotService: RiotService
  
  private(set) var page: Int = 0
  private(set) var size: Int = 20
  private(set) var hasNext: Bool = false
  
  @Published var errorMsg: String? = nil
  @Published var isMy: Bool = false
  
  @Published private(set) var showSelectPositionView: Bool = false
  @Published private(set) var selectedChatroom: ChatroomEntity? = nil
  @Published private(set) var chatroomList: [ChatroomEntity] = []
  @Published private(set) var myRoomList: [MyChatroomContent] = []
  
  public init(
    chatService: ChatService,
    riotService: RiotService,
    coordinator: ChatCoordinator
  ) {
    self.service = chatService
    self.riotService = riotService
    super.init(coordinator: coordinator)
  }
  
  public func action(_ action: Action) {
    switch action {
    case .viewAppear:
      self.selectedChatroom = nil
      self.page = 0
      self.hasNext = false
      self.chatroomList.removeAll()
      self.myRoomList.removeAll()
      self.action(._fetchChatroomList(isMy: self.isMy))
      
    case let .tappedChatroom(chatroom):
      Task {
        await self.checkAccount()
        
        DispatchQueue.main.async {
          if UserDefaultsList.RiotAccount.userId != nil {
            self.selectedChatroom = chatroom
            self.showSelectPositionView = true
          } else {
            self.errorMsg = "프로필에서 유저 정보를 등록해주세요!"
          }
        }
      }
      
    case let .tappedSelectPositionButton(position):
      if let roomId = self.selectedChatroom?.roomId {
        Task {
          await self.selectPosition(roomId: roomId, position: position)
        }
      }
      
    case let .tappedMyRoom(roomData):
      self.coordinator.push(
        page: .inChatting(
          ChatroomEntity(
            roomId: roomData.roomId,
            roomName: roomData.roomName,
            userCount: roomData.users.count,
            maxUserCount: 10,
            leaderTierText: "test",
            leaderTier: .bronze,
            positions: [])
        )
      )
      
    case let ._setPage(page):
      self.page = page
      
    case let ._fetchChatroomList(isMy):
      Task {
        if !isMy {
          await self.fetchChatList(page: self.page, size: self.size)
        } else {
          await self.fetchMyRoom(page: self.page, size: self.size)
        }
      }
      
    case ._fetchNextPage:
      if hasNext {
        self.page += 1
        self.action(._fetchChatroomList(isMy: self.isMy))
      }
      
    case ._moveFilterList:
      self.coordinator.push(page: .filterList)
      
    case ._moveUserDetailCarousel:
      if let roomData = self.selectedChatroom {
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
  func checkAccount() async {
    self.riotService.checkAccount { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case let .success(data):
        UserDefaultsList.setRiotAccount(userId: data.userId, summonerName: data.summonerName)
        
      case let .failure(error):
        switch error {
        case .requestErr, .requestFailed, .serverError, .unknown:
          self.errorMsg = error.localizedDescription
          
        default:
          self.errorMsg = "유저 정보가 없습니다.\n프로필 탭에서 유저 정보를 등록해주세요."
        }
      }
    }
  }
  
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
  func fetchMyRoom(page: Int, size: Int) async {
    service.fetchMyRoom(page: page, size: size) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case let .success(data):
        self.myRoomList.append(contentsOf: data.content)
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
