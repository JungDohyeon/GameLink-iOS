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
  }
}
