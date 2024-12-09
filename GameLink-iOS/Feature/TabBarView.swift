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
      Group {
        categoryView()
        
        chattingView()
        
        profileView()
        
        settingView()
      }
      .toolbarBackground(.glBackground2, for: .tabBar)
    }
    .tint(.glPrimary3)
    .onAppear {
      UITabBar.appearance().backgroundColor = .background2
    }
    .navigationBarBackButtonHidden()
  }
}

private extension TabBarView {
  
  @ViewBuilder
  func categoryView() -> some View {
    Text("카테고리 뷰")
      .tabItem {
        Label(
          title: { Text("카테고리") },
          icon: {
            Image(.categoryIcon)
              .renderingMode(.template)
          }
        )
      }
      .tag(1)
  }
  
  @ViewBuilder
  func chattingView() -> some View {
    NavigationStack(path: $chatCoordinator.path) {
      chatCoordinator.buildInitialScene()
        .navigationDestination(for: ChatScene.self) { destination in
          chatCoordinator.buildScene(scene: destination)
        }
    }
    .tabItem {
      Label(
        title: { Text("채팅") },
        icon: {
          Image(.chatIcon)
            .renderingMode(.template)
        }
      )
    }
    .tag(2)
  }
  
  @ViewBuilder
  func profileView() -> some View {
    ProfileMainView()
      .environmentObject(profileViewModel)
      .tabItem {
        Label(
          title: { Text("프로필") },
          icon: {
            Image(.profileIcon)
              .renderingMode(.template)
          }
        )
      }
      .tag(3)
  }
  
  @ViewBuilder
  func settingView() -> some View {
    Text("설정 뷰")
      .tabItem {
        Label(
          title: { Text("설정") },
          icon: {
            Image(.settingIcon)
              .renderingMode(.template)
          }
        )
      }
      .tag(4)
  }
}

#Preview {
  TabBarView(chatCoordinator: ChatCoordinator(initialScene: .filterList))
}
