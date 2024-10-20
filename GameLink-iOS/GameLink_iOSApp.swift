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
  
  @StateObject private var authViewModel: AuthViewModel = AuthViewModel()
  
  init() {
    
  }
  
  var body: some Scene {
    WindowGroup {
      if authViewModel.isLogin {
        ChattingListView()
      } else {
        AuthView()
          .environmentObject(authViewModel)
      }
    }
  }
}
