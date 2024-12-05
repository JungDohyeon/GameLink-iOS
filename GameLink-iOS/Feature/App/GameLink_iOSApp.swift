//
//  GameLink_iOSApp.swift
//  GameLink-iOS
//
//  Created by 정도현 on 9/21/24.
//

import SwiftUI
import Swinject

@main
struct GameLink_iOSApp: App {
  
  @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
  
  @StateObject private var authViewModel = AuthViewModel(service: DefaultUserService())
  @State private var isLogin = false
  
  private let chatCoordinator: ChatCoordinator
  private let injector: Injector
  
  init() {
    chatCoordinator = ChatCoordinator(initialScene: .main)
    injector = DependencyInjector(container: Container())
    
    // Dependency Assembly
    injector.assemble([
      ServiceAssembly(),
      ChatAssembly(coordinator: chatCoordinator)
    ])
    chatCoordinator.injector = injector
  }
  
  var body: some Scene {
    WindowGroup {
      Group {
        if isLogin || authViewModel.isLogin {
          TabBarView(chatCoordinator: chatCoordinator)
        } else {
          AuthView().environmentObject(authViewModel)
        }
      }
      .task { await checkAuthStatus() }
    }
  }
  
  private func checkAuthStatus() async {
    guard let refreshToken = UserDefaultsList.Auth.refreshToken else { return }
    
    DefaultUserService().reissue(refreshToken: refreshToken) { result in
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
