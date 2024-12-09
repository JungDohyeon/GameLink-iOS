//
//  InChattingViewModel.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/6/24.
//

import Combine
import Foundation

final class InChattingViewModel: BaseViewModel<ChatCoordinator>, ObservableObject {
  
  public enum Action {
    // User Action
    
    // Inner Business Action
    case _viewAppear(_ roomData: ChatroomEntity)
    case _stompConnect
    case _sendMessage(_ text: String)
    case _stompDisconnect
    
    // pageAction
    case _moveBack
  }
  
  private let stompService: DefaultStompService
  
  private var cancellables = Set<AnyCancellable>()
  
  private(set) var page: Int = 0
  private(set) var size: Int = 10
  private(set) var hasNext: Bool = true
  
  private(set) var userId: String? = nil
  private(set) var userName: String? = nil
  
  private(set) var roomData: ChatroomEntity? = nil
  
  @Published private(set) var chatMessages: [ChatContentDTO] = []
  
  public init(
    stompService: DefaultStompService,
    coordinator: ChatCoordinator
  ) {
    self.stompService = stompService
    super.init(coordinator: coordinator)
    
    self.stompService.messagesPublisher
      .sink { completion in
        switch completion {
        case .finished:
          print("Finished receiving messages.")
        case .failure(let error):
          print("Error occurred: \(error)")
        }
      } receiveValue: { messages in
        self.chatMessages.append(contentsOf: messages)
      }
      .store(in: &cancellables)
  }
  
  public func action(_ action: Action) {
    switch action {
    case let ._viewAppear(roomData):
      if let userId = UserDefaultsList.RiotAccount.userId, let userName = UserDefaultsList.RiotAccount.summonerName {
        self.userId = userId
        self.userName = userName
        
        self.page = 0
        self.roomData = roomData
        
        self.chatMessages.removeAll()
        self.action(._stompConnect)
      } else {
        print("계정 정보가 없습니다.")
      }
      
    case ._stompConnect:
      Task {
        if let roomData = self.roomData {
          await self.stompConnect(roomId: roomData.roomId)
        }
      }
      
    case let ._sendMessage(text):
      if let roomData = self.roomData {
        Task {
          await self.sendMessage(text: text)
        }
      }
      
    case ._stompDisconnect:
      Task {
        await self.stompDisconnect()
      }
      
    case ._moveBack:
      self.coordinator.pop()
    }
  }
}

// MARK: STOMP Service
@MainActor
private extension InChattingViewModel {
  func stompConnect(roomId: String) async {
    if let userId = self.userId, let userName = self.userName {
      self.stompService.connect(roomId: roomId, userId: userId, userName: userName)
    }
  }
  
  func sendMessage(text: String) async {
    if let userName = UserDefaultsList.RiotAccount.summonerName {
      self.stompService.send(nickname: userName, body: text)
    }
  }
  
  func stompDisconnect() async {
    self.stompService.disconnect()
  }
}

// MARK: Chat Service
@MainActor
private extension InChattingViewModel {
  
}
