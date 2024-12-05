//
//  BaseCoordinator.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/5/24.
//

import SwiftUI

class BaseCoordinator<Page: Hashable>: CoordinatorProtocol, ObservableObject {
  
  @Published var path: NavigationPath = NavigationPath()
  var injector: Injector?
  
  func push(page: Page) {
    path.append(page)
  }
  
  func pop() {
    if !path.isEmpty {
      path.removeLast()
    }
  }
  
  func popToRoot() {
    path.removeLast(path.count)
  }
}
