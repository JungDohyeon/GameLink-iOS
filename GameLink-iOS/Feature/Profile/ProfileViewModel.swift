//
//  ProfileViewModel.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/25/24.
//

import Combine
import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
  
  public enum Action {
    // User Action
    case mainViewAppear
    
    // Inner Business Action
  }
  
  private let service: RiotService
  
  public init(
    service: RiotService
  ) {
    self.service = service
  }
}
