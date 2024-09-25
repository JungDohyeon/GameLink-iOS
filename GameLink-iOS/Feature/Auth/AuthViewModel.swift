//
//  AuthViewModel.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Combine
import Foundation
import KakaoSDKUser

final class AuthViewModel: ObservableObject {
  
  public enum Action {
    // User Action
    case mainViewAppear
    case tappedLogin(AuthProvider)
    
    // Inner Business Action
    case _setLoginType(AuthProvider)
  }
  
  public func action(_ action: Action) {
    switch action {
    case let .tappedLogin(authProvider):
      switch authProvider {
      case .kakao:
        self.handleKakaoLogin()
      }
      
    default:
      return
    }
  }
}

// MARK: KAKAO LOGIN
private extension AuthViewModel {
  func handleKakaoLogin() {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          print("ERROR!")
          print(error.localizedDescription)
        }
        else {
          print("TOKEN: \(oauthToken?.accessToken)")
          self.signUpUserWithSocialLogin(loginPath: .kakao)
        }
      }
    } else {
      UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
        if let error = error {
          print("ERROR!")
          print(error.localizedDescription)
        }
        else {
          print("TOKEN: \(oauthToken?.accessToken)")
          self.signUpUserWithSocialLogin(loginPath: .kakao)
        }
      }
    }
  }
  
  
  func signUpUserWithSocialLogin(loginPath: AuthProvider) {
    switch loginPath {
    case .kakao:
      return
    }
  }
  
  // MARK: Logout
  func handleKakaoLogout() async -> Bool {
    await withCheckedContinuation { continuation in
      UserApi.shared.logout {(error) in
        if let error = error {
          print(error)
          continuation.resume(returning: false)
        }
        else {
          print("logout() success.")
          continuation.resume(returning: true)
        }
      }
    }
  }
}
