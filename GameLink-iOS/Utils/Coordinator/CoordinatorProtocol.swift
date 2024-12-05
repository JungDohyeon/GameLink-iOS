//
//  Coordinator.swift
//  GameLink-iOS
//
//  Created by 정도현 on 12/5/24.
//

import SwiftUI

public protocol CoordinatorProtocol {
  associatedtype Page: Hashable
  
  var path: NavigationPath { get set }
  
  func push(page: Page)
  func pop()
  func popToRoot()
}
