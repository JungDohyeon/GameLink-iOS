//
//  ChatCoordinator.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/5/24.
//

import SwiftUI

public enum ChatScene: Hashable {
  case main
  case filterList
  case userCarousel(_ roomData: ChatroomEntity)
  case inChatting(_ roomData: ChatroomEntity)
}

final class ChatCoordinator: BaseCoordinator<ChatScene> {
  private let initialScene: ChatScene
  
  public init(initialScene: ChatScene) {
    self.initialScene = initialScene
    super.init()
    
    path.append(initialScene)
  }
  
  public func buildInitialScene() -> some View {
    buildScene(scene: initialScene)
  }
  
  @ViewBuilder
  public func buildScene(scene: ChatScene) -> some View {
    switch scene {
    case .main:
      injector?.resolve(ChattingListView.self)
    case .filterList:
      injector?.resolve(ChattingFilterDetailView.self)
    case let .userCarousel(roomData):
      injector?.resolve(ChattingRoomCarouselView.self, argument: roomData)
    case let .inChatting(roomData):
      injector?.resolve(InChattingView.self, argument: roomData)
    }
  }
}
