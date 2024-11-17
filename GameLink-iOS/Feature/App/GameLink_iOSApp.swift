//
//  GameLink_iOSApp.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import SwiftUI

@main
struct GameLink_iOSApp: App {
  
  @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
  
  @State var isLogin: Bool = false
  
  @StateObject private var authViewModel: AuthViewModel = AuthViewModel(service: DefaultUserService())
  
  init() {
    
  }
  
  var body: some Scene {
    WindowGroup {
      Group {
        if self.isLogin || authViewModel.isLogin {
          TabBarView()
        } else {
          AuthView()
            .environmentObject(authViewModel)
        }
      }
      .task {
        guard let refresehToken = UserDefaultsList.Auth.refreshToken else {
          return
        }
        
        DefaultUserService().reissue(refreshToken: refresehToken) { result in
          switch result {
          case let .success(data):
            UserDefaultsList.setAuthToken(accessToken: data.accessToken, refreshToken: data.refreshToken)
            self.isLogin = true
            
          case .failure:
            UserDefaultsList.clearAuthData()
          }
        }
      }
    }
  }
}
