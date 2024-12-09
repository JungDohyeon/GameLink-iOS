//
//  ServiceAssembly.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/6/24.
//

import Swinject

/// Service Assembly
public struct ServiceAssembly: Assembly {
  
  public func assemble(container: Container) {
    container.register(DefaultChatService.self) { _ in
      DefaultChatService()
    }
    
    container.register(DefaultRiotService.self) { _ in
      DefaultRiotService()
    }
    
    container.register(DefaultStompService.self) { resolver in
      let service = resolver.resolve(DefaultChatService.self)!
      return DefaultStompService(service: service)
    }
  }
}
