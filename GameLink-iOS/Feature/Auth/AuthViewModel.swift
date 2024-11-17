//
//  AuthViewModel.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/26/24.
//

import Combine
import Foundation
import KakaoSDKAuth
import KakaoSDKUser

@MainActor
final class AuthViewModel: ObservableObject {
  
  @Published private(set) var isLogin: Bool = false
  
  public enum Action {
    // User Action
    case tappedLogin(AuthProvider)
    
    // Inner Business Action
    case _mainViewAppear
    case _setLoginType(AuthProvider)
  }
  
  private let service: UserService
  
  init(service: UserService) {
    self.service = service
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
        if let oauthToken = oauthToken {
          self.signUpUserWithSocialLogin(loginPath: .kakao, token: oauthToken)
        } else {
          print("Kakao Login Error")
        }
        
        if let error = error {
          print(error.localizedDescription)
        }
      }
    } else {
      UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
        if let oauthToken = oauthToken {
          self.signUpUserWithSocialLogin(loginPath: .kakao, token: oauthToken)
        } else {
          print("Kakao Login Error")
        }
        
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
  
  func signUpUserWithSocialLogin(loginPath: AuthProvider, token: OAuthToken) {
    switch loginPath {
    case .kakao:
      UserApi.shared.me() { (user, error) in
        if let error = error {
          print(error.localizedDescription)
        } else {
          if let user = user {
            self.service.kakaoLogin(
              accessToken: token.accessToken,
              deviceId: Utils.getDeviceUUID()
            ) { result in
              switch result {
              case let .success(data):
                UserDefaultsList.setAuthToken(accessToken: data.accessToken, refreshToken: data.refreshToken)
                self.isLogin = true
                
              case let .failure(error):
                print(error.localizedDescription)
                return
              }
            }
          }
        }
      }
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
