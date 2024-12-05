//
//  TabBarView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/24/24.
//

import SwiftUI

struct TabBarView: View {
  
  @StateObject private var profileViewModel: ProfileViewModel = ProfileViewModel(service: DefaultRiotService())
  
  @ObservedObject private var chatCoordinator: ChatCoordinator
  
  init(chatCoordinator: ChatCoordinator) {
    self.chatCoordinator = chatCoordinator
  }
  
  @State private var selection = 1
  
  var body: some View {
    TabView(selection: $selection) {
      Text("카테고리 뷰")
        .tabItem { Text("카테고리 뷰") }
        .tag(1)
      
      NavigationStack(path: $chatCoordinator.path) {
        chatCoordinator.buildInitialScene()
          .navigationDestination(for: ChatScene.self) { destination in
            chatCoordinator.buildScene(scene: destination)
          }
      }
      .tabItem { Text("채팅") }
      .tag(2)
      
      ProfileMainView()
        .environmentObject(profileViewModel)
        .tabItem { Text("프로필") }
        .tag(3)
      
      Text("설정 뷰")
        .tabItem { Text("설정") }
        .tag(4)
    }
  }
}

#Preview {
  TabBarView(chatCoordinator: ChatCoordinator(initialScene: .filterList))
}
