//
//  BaseViewModel.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/6/24.
//

import Foundation

public class BaseViewModel<C: CoordinatorProtocol>: NSObject {
  @Published public var coordinator: C
  
  public init(coordinator: C) {
    self.coordinator = coordinator
  }
}
