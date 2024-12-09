//
//  ChatAssembly.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/5/24.
//

import Swinject

/// Presentation-Chat Assembly
public struct ChatAssembly: Assembly {
  
  let coordinator: ChatCoordinator
  
  public func assemble(container: Container) {
    container.register(ChattingListViewModel.self) { resolver in
      let service = resolver.resolve(DefaultChatService.self)!
      let riotService = resolver.resolve(DefaultRiotService.self)!
      return ChattingListViewModel(chatService: service, riotService: riotService, coordinator: coordinator)
    }.inObjectScope(.container) /// ViewModel이 계속 새로 생성되는 것을 방지하기 위해 Scope(.container) 설정 (SingleTon)
   
    container.register(ChattingRoomCarouselViewModel.self) { resolver in
      let service = resolver.resolve(DefaultChatService.self)!
      return ChattingRoomCarouselViewModel(chatService: service, coordinator: coordinator)
    }.inObjectScope(.container)
    
    container.register(InChattingViewModel.self) { resolver in
      let stompService = resolver.resolve(DefaultStompService.self)!
      return InChattingViewModel(stompService: stompService, coordinator: coordinator)
    }.inObjectScope(.container)
    
    container.register(ChattingListView.self) { resolver in
      let viewModel = resolver.resolve(ChattingListViewModel.self)!
      return ChattingListView(viewModel: viewModel)
    }
    
    container.register(ChattingFilterDetailView.self) { resolver in
      let viewModel = resolver.resolve(ChattingListViewModel.self)!
      return ChattingFilterDetailView(viewModel: viewModel)
    }
    
    container.register(ChattingRoomCarouselView.self) { (resolver, roomData: ChatroomEntity) in
      let viewModel = resolver.resolve(ChattingRoomCarouselViewModel.self)!
      return ChattingRoomCarouselView(viewModel: viewModel, roomData: roomData)
    }
    
    container.register(InChattingView.self) { (resolver, roomData: ChatroomEntity) in
      let viewModel = resolver.resolve(InChattingViewModel.self)!
      return InChattingView(viewModel: viewModel, roomData: roomData)
    }
  }
}
