//
//  TabBarView.swift
//  GameLink-iOS
//
//  Created by 정도현 on 10/24/24.
//

import SwiftUI

struct TabBarView: View {
  @State private var selection = 1
  
  var body: some View {
    TabView(selection: $selection) {
      Text("카테고리 뷰")
        .tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }
        .tag(1)
      
      ChattingListView()
        .tabItem { Text("채팅") }
        .tag(2)
      
      ProfileMainView()
        .tabItem { Text("프로필") }
        .tag(2)
      
      Text("설정 뷰")
        .tabItem { Text("설정") }
        .tag(2)
    }
  }
}

#Preview {
  TabBarView()
}
