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
  
  @Published private(set) var nickname: String = ""
  @Published private(set) var tag: String = ""
  
  @Published private(set) var userProfileInfo: RiotAccountDTO? = nil
  
  public enum Action {
    // User Action
    case mainViewAppear
    case tappedRegistButton
    
    // Inner Business Action
    case _setNickname(String)
    case _setTag(String)
  }
  
  private let service: RiotService
  
  public init(
    service: RiotService
  ) {
    self.service = service
  }
  
  public func action(_ action: Action) {
    switch action {
    case .mainViewAppear:
      self.fetchUserInfo()
    
    case .tappedRegistButton:
      self.registerAccount(gameName: nickname, tagLine: tag)
      
    case let ._setNickname(text):
      self.setNickname(text: text)
      
    case let ._setTag(text):
      self.setTag(text: text)
      
    default:
      return
    }
  }
  
  private func setNickname(text: String) {
    self.nickname = text
  }
  
  private func setTag(text: String) {
    self.tag = text
  }
}

private extension ProfileViewModel {
  
  func fetchUserInfo() {
    self.service.checkAccount { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case let .success(data):
        self.userProfileInfo = data
        
      case let .failure(error):
        switch error {
        case .requestErr, .requestFailed, .serverError, .unknown:
          print(error.localizedDescription)
          
        default:
          print("유저 정보 없음!")
        }
      }
    }
  }
  
  func registerAccount(gameName: String, tagLine: String) {
    self.service.registerAccount(gameName: gameName, tagLine: tagLine) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success:
        print("SUCCESS!")
        self.fetchUserInfo()
        
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
